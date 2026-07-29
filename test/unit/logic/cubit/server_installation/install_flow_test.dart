import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
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
  setUpAll(() => registerFallbackValue(aServerHostingDetails()));

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
    when(() => repository.saveServerDetails(any())).thenAnswer((_) async {});
  });

  tearDown(() async {
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

    test('records the reboot and keeps the returned details', () async {
      final ServerHostingDetails rebooted = aServerHostingDetails().copyWith(
        startTime: DateTime.utc(2026, 7, 27, 12),
      );
      when(() => repository.restart()).thenAnswer((_) async => rebooted);

      await cubit.rebootServer(state: afterCertificate());

      verify(
        () => repository.saveIsServerRebooted(serverRebooted: true),
      ).called(1);
      verify(() => repository.saveServerDetails(rebooted)).called(1);
      expect(cubit.state.isServerRebooted, isTrue);
    });

    test('retries instead of advancing when the reboot fails', () async {
      when(() => repository.restart()).thenAnswer((_) async => null);

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
