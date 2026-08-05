import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../../../../helpers/fixtures/credential_fixtures.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';

class _MockRepository extends Mock implements ServerInstallationRepository {}

ServerInstallationNotFinished _stateAfterServerStarted({
  final bool isCertificateVerified = false,
}) => ServerInstallationNotFinished(
  providerApiToken: 'srv-token',
  serverTypeIdentificator: 'cx22',
  serverLocation: 'fsn1',
  dnsApiCredential: aDnsProviderCredential(),
  serverDomain: aServerDomain(),
  rootUser: const User.fake(),
  serverDetails: aServerHostingDetails(),
  isServerStarted: true,
  isCertificateVerified: isCertificateVerified,
  isServerRebooted: false,
  isLoading: false,
  dnsMatches: null,
  customSshKey: null,
);

void main() {
  late _MockRepository repository;
  late ServerInstallationCubit cubit;

  setUp(() {
    repository = _MockRepository();
    cubit = ServerInstallationCubit(repository: repository);

    when(
      () => repository.saveIsCertificateVerified(
        certificateVerified: any(named: 'certificateVerified'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => repository.saveIsServerRebooted(
        serverRebooted: any(named: 'serverRebooted'),
      ),
    ).thenAnswer((_) async {});
  });

  tearDown(() async {
    cubit.closeTimer();
    await cubit.close();
  });

  test('an unreachable server keeps waiting and sends nothing', () async {
    when(
      () => repository.probeServer(),
    ).thenAnswer((_) async => ServerProbeResult.unreachable);

    await cubit.waitForCertificate(state: _stateAfterServerStarted());

    verifyNever(() => repository.restart());
    verifyNever(
      () => repository.saveIsCertificateVerified(
        certificateVerified: any(named: 'certificateVerified'),
      ),
    );
  });

  test(
    'a self-signed certificate keeps waiting rather than rebooting',
    () async {
      when(
        () => repository.probeServer(),
      ).thenAnswer((_) async => ServerProbeResult.untrustedCertificate);

      await cubit.waitForCertificate(state: _stateAfterServerStarted());

      // The reboot is the first authenticated call of the install, so it must
      // not run while the server is still serving its ACME placeholder.
      verifyNever(() => repository.restart());
      expect(
        (cubit.state as ServerInstallationNotFinished).isWaitingForCertificate,
        isTrue,
      );
    },
  );

  test('a verified certificate records the gate as passed', () async {
    when(
      () => repository.probeServer(),
    ).thenAnswer((_) async => ServerProbeResult.reachable);

    await cubit.waitForCertificate(state: _stateAfterServerStarted());

    verify(
      () => repository.saveIsCertificateVerified(certificateVerified: true),
    ).called(1);
    expect(cubit.state.isCertificateVerified, isTrue);
  });

  group('rebootServer', () {
    ServerInstallationNotFinished afterCertificate() =>
        _stateAfterServerStarted(isCertificateVerified: true);

    test('records the reboot once the server accepts it', () async {
      when(() => repository.restart()).thenAnswer((_) async => true);

      await cubit.rebootServer(state: afterCertificate());

      verify(
        () => repository.saveIsServerRebooted(serverRebooted: true),
      ).called(1);
      expect(cubit.state.isServerRebooted, isTrue);
    });

    test('retries instead of advancing when the reboot fails', () async {
      when(() => repository.restart()).thenAnswer((_) async => false);

      await cubit.rebootServer(state: afterCertificate());

      verifyNever(
        () => repository.saveIsServerRebooted(
          serverRebooted: any(named: 'serverRebooted'),
        ),
      );
      expect(cubit.state.isServerRebooted, isFalse);
    });
  });

  test(
    'a self-signed retry clears a stale certificate flag, so the wizard does '
    'not falsely claim success',
    () async {
      when(
        () => repository.probeServer(),
      ).thenAnswer((_) async => ServerProbeResult.untrustedCertificate);

      await cubit.waitForCertificate(
        state: _stateAfterServerStarted(isCertificateVerified: true),
      );

      expect(cubit.state.isCertificateVerified, isFalse);
      expect(
        (cubit.state as ServerInstallationNotFinished).isWaitingForCertificate,
        isTrue,
      );
    },
  );

  group('a certificate that never arrives', () {
    ServerInstallationNotFinished current() =>
        cubit.state as ServerInstallationNotFinished;

    // The count lives in the state, so each probe has to be handed the state
    // the previous one produced, exactly as runDelayed does in the real loop.
    Future<void> waitOut(final int attempts) async {
      when(
        () => repository.probeServer(),
      ).thenAnswer((_) async => ServerProbeResult.untrustedCertificate);

      ServerInstallationNotFinished state = _stateAfterServerStarted();
      for (int i = 0; i < attempts; i++) {
        await cubit.waitForCertificate(state: state);
        state = current();
      }
    }

    bool stalled() => current().isCertificateStalled;

    test('keeps quiet while the wait is still plausible', () async {
      await waitOut(
        ServerInstallationCubit.certificateAttemptsBeforePrompt - 1,
      );

      expect(stalled(), isFalse);
    });

    test('eventually tells the user something is wrong', () async {
      await waitOut(ServerInstallationCubit.certificateAttemptsBeforePrompt);

      expect(stalled(), isTrue);
    });

    test('keeps probing after it has given up quietly', () async {
      await waitOut(
        ServerInstallationCubit.certificateAttemptsBeforePrompt + 3,
      );

      expect(stalled(), isTrue);
      verify(
        () => repository.probeServer(),
      ).called(ServerInstallationCubit.certificateAttemptsBeforePrompt + 3);
    });

    test('a certificate that does arrive clears the count', () async {
      await waitOut(ServerInstallationCubit.certificateAttemptsBeforePrompt);
      when(
        () => repository.probeServer(),
      ).thenAnswer((_) async => ServerProbeResult.reachable);

      await cubit.waitForCertificate(state: current());

      expect(current().certificateAttempts, 0);
      expect(stalled(), isFalse);
    });
  });

  test('a rebooted server resumes at the final checks', () async {
    when(() => repository.load()).thenAnswer(
      (_) async => _stateAfterServerStarted(
        isCertificateVerified: true,
      ).copyWith(isServerRebooted: () => true),
    );
    when(() => repository.isHttpServerWorking()).thenAnswer((_) async => false);

    await cubit.load();

    verify(() => repository.isHttpServerWorking()).called(1);
    verifyNever(() => repository.probeServer());
    verifyNever(() => repository.restart());
  });

  test('a persisted certificate flag is re-probed, never trusted', () async {
    // An install interrupted under the old two-reboot semantics can have this
    // flag set without the certificate ever having been verified.
    when(() => repository.load()).thenAnswer(
      (_) async => _stateAfterServerStarted(isCertificateVerified: true),
    );
    when(
      () => repository.probeServer(),
    ).thenAnswer((_) async => ServerProbeResult.untrustedCertificate);

    await cubit.load();

    verify(() => repository.probeServer()).called(1);
    verifyNever(() => repository.restart());
  });
}
