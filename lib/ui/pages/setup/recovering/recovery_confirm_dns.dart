import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoveryConfirmDns extends StatelessWidget {
  const RecoveryConfirmDns({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (final BuildContext context) => DnsProviderFormCubit(appConfig),
      child: Builder(
        builder: (final BuildContext context) {
          final FormCubitState formCubitState =
              context.watch<DnsProviderFormCubit>().state;
          final String providerDisplayName =
              appConfig.state.serverDomain?.provider.displayName ??
              'DNS Provider';
          final String providerSupportArticle =
              appConfig.state.serverDomain?.provider.supportArticle ?? '';
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
            onBackButtonPressed:
                context.read<ServerInstallationCubit>().revertRecoveryStep,
            children: [
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: context.read<DnsProviderFormCubit>().apiKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'recovering.provider_connected_placeholder'.tr(
                    args: [providerDisplayName],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BrandButton.filled(
                onPressed:
                    formCubitState.isSubmitting
                        ? null
                        : () =>
                            context.read<DnsProviderFormCubit>().trySubmit(),
                title: 'basis.connect'.tr(),
              ),
              const SizedBox(height: 16),
              Builder(
                builder:
                    (final context) => BrandButton.text(
                      onPressed:
                          () => context.read<SupportSystemCubit>().showArticle(
                            article: providerSupportArticle,
                            context: context,
                          ),
                      title: 'initializing.how'.tr(),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
