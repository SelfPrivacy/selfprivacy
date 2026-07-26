import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../../../../helpers/fixtures/credential_fixtures.dart';

class _MockRepository extends Mock implements ServerInstallationRepository {}

ServerInstallationNotFinished _stateAfterServerStarted({
  final bool isCertificateVerified = false,
}) => ServerInstallationNotFinished(
  providerApiToken: 'srv-token',
  serverTypeIdentificator: 'cx22',
  serverLocation: 'fsn1',
  dnsApiCredential: aDnsProviderCredential(),
  serverDomain: ServerDomain(
    domainName: 'example.org',
    provider: DnsProviderType.cloudflare,
  ),
  rootUser: const User.fake(),
  serverDetails: ServerHostingDetails(
    ip4: '203.0.113.10',
    id: 1,
    createTime: null,
    volume: ServerProviderVolume(
      id: 0,
      name: '',
      sizeByte: 0,
      serverId: 1,
      linuxDevice: '',
    ),
    apiToken: 'api-token',
    provider: ServerProviderType.hetzner,
  ),
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
