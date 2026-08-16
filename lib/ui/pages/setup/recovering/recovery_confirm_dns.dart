import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/forms/credential_checks/dns_provider_credential_check.dart';
import 'package:selfprivacy/logic/forms/dns_provider_form.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/dns_provider_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoveryConfirmDns extends StatefulWidget {
  const RecoveryConfirmDns({super.key});

  @override
  State<RecoveryConfirmDns> createState() => _RecoveryConfirmDnsState();
}

class _RecoveryConfirmDnsState extends State<RecoveryConfirmDns> {
  late final ServerInstallationCubit appConfig;
  late final DnsProviderType providerType;
  late final DnsProviderForm dnsProviderForm;

  @override
  void initState() {
    super.initState();
    appConfig = context.read<ServerInstallationCubit>();
    providerType =
        appConfig.state.serverDomain?.provider ?? DnsProviderType.unknown;
    dnsProviderForm = DnsProviderForm(
      providerType: providerType,
      validateCredential: checkDnsProviderCredential,
      onSubmit: appConfig.setDnsApiCredential,
    );
  }

  @override
  void dispose() {
    dnsProviderForm.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final String providerDisplayName = providerType.displayName;
    final String providerSupportArticle = providerType.supportArticle;
    return BrandHeroScreen(
      heroTitle: 'recovering.provider_connected'.tr(
        args: [providerDisplayName],
      ),
      heroSubtitle: 'recovering.provider_connected_description'.tr(
        args: [appConfig.state.serverDomain?.domainName ?? 'your domain'],
      ),
      hasBackButton: true,
      hasFlashButton: false,
      ignoreBreakpoints: true,
      hasSupportDrawer: true,
      onBackButtonPressed: context
          .read<ServerInstallationCubit>()
          .revertRecoveryStep,
      children: [
        DnsProviderFormView(
          dnsProviderForm: dnsProviderForm,
          tokenLabel: 'recovering.provider_connected_placeholder'.tr(
            args: [providerDisplayName],
          ),
          submitLabel: 'basis.connect'.tr(),
        ),
        const SizedBox(height: 16),
        Builder(
          builder: (final context) => BrandButton.text(
            onPressed: () => context.read<SupportSystemCubit>().showArticle(
              article: providerSupportArticle,
              context: context,
            ),
            title: 'initializing.how'.tr(),
          ),
        ),
      ],
    );
  }
}
