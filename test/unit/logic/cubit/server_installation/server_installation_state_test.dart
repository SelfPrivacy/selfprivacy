import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';

ServerHostingDetails _serverDetails() => ServerHostingDetails(
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
);

ServerInstallationWizardData _wizardData({
  final bool isCertificateVerified = false,
  final bool isServerRebooted = false,
}) => ServerInstallationWizardData.empty().copyWith(
  serverProviderKey: () => 'srv-token',
  serverTypeIdentifier: 'cx22',
  serverLocation: 'fsn1',
  dnsProviderToken: 'dns-token',
  dnsProviderType: DnsProviderType.cloudflare,
  rootUser: const User.fake(),
  serverDetails: _serverDetails,
  serverDomain: () => ServerDomain(
    domainName: 'example.org',
    provider: DnsProviderType.cloudflare,
  ),
  isServerStarted: true,
  isCertificateVerified: isCertificateVerified,
  isServerRebooted: isServerRebooted,
);

void main() {
  group('progress', () {
    test('a started server that has no certificate yet', () {
      final state = ServerInstallationNotFinished.fromWizardData(_wizardData());

      expect(state.progress, ServerSetupProgress.serverStarted);
      expect(state.isFullyInitialized, isFalse);
    });

    test('a verified certificate advances one step', () {
      final state = ServerInstallationNotFinished.fromWizardData(
        _wizardData(isCertificateVerified: true),
      );

      expect(state.progress, ServerSetupProgress.certificateVerified);
      expect(state.progressBar, 5);
    });

    test('a rebooted server is the last step before the final checks', () {
      final state = ServerInstallationNotFinished.fromWizardData(
        _wizardData(isCertificateVerified: true, isServerRebooted: true),
      );

      expect(state.progress, ServerSetupProgress.serverRebooted);
      expect(state.progressBar, 6);
      expect(state.isFullyInitialized, isTrue);
    });
  });

  group('equality', () {
    test('the reboot transition is not equal to its predecessor', () {
      final before = ServerInstallationNotFinished.fromWizardData(
        _wizardData(isCertificateVerified: true),
      );

      expect(before == before.copyWith(isServerRebooted: () => true), isFalse);
    });

    test('the certificate transition is not equal to its predecessor', () {
      final before = ServerInstallationNotFinished.fromWizardData(
        _wizardData(),
      );

      expect(
        before == before.copyWith(isCertificateVerified: () => true),
        isFalse,
      );
    });

    test('the waiting-for-certificate hint changes identity too', () {
      final before = ServerInstallationNotFinished.fromWizardData(
        _wizardData(),
      );

      expect(
        before == before.copyWith(isWaitingForCertificate: () => true),
        isFalse,
      );
    });
  });

  test('copyWith leaves untouched fields alone', () {
    final state = ServerInstallationNotFinished.fromWizardData(
      _wizardData(isCertificateVerified: true),
    );

    final updated = state.copyWith(isServerRebooted: () => true);

    expect(updated.isCertificateVerified, isTrue);
    expect(updated.isServerStarted, isTrue);
    expect(updated.serverDomain, state.serverDomain);
    expect(updated.rootUser, state.rootUser);
    expect(updated.isWaitingForCertificate, isFalse);
  });

  test('the waiting hint is not part of the step count', () {
    final state = ServerInstallationNotFinished.fromWizardData(_wizardData());

    expect(
      state.copyWith(isWaitingForCertificate: () => true).progress,
      state.progress,
    );
  });

  test('a finished installation carries both gates as passed', () {
    final finished = ServerInstallationNotFinished.fromWizardData(
      _wizardData(isCertificateVerified: true, isServerRebooted: true),
    ).finish();

    expect(finished.isCertificateVerified, isTrue);
    expect(finished.isServerRebooted, isTrue);
    expect(finished.serverDomain?.domainName, 'example.org');
  });
}
