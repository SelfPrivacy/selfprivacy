import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

class RecoveryConfirmCloudflare extends StatelessWidget {
  const RecoveryConfirmCloudflare({super.key});

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

          return BrandHeroScreen(
            heroTitle: 'recovering.confirm_cloudflare'.tr(),
            heroSubtitle: 'recovering.confirm_cloudflare_description'.tr(
              args: [appConfig.state.serverDomain?.domainName ?? 'your domain'],
            ),
            hasBackButton: true,
            hasFlashButton: false,
            onBackButtonPressed:
                context.read<ServerInstallationCubit>().revertRecoveryStep,
            children: [
              CubitFormTextField(
                formFieldCubit: context.read<DnsProviderFormCubit>().apiKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'initializing.cloudflare_api_token'.tr(),
                ),
              ),
              const SizedBox(height: 16),
              BrandButton.rised(
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<DnsProviderFormCubit>().trySubmit(),
                text: 'basis.connect'.tr(),
              ),
              const SizedBox(height: 16),
              BrandButton.text(
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (final BuildContext context) => BrandBottomSheet(
                    isExpended: true,
                    child: Padding(
                      padding: paddingH15V0,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        children: const [
                          BrandMarkdown(
                            fileName: 'how_cloudflare',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                title: 'initializing.how'.tr(),
              ),
            ],
          );
        },
      ),
    );
  }
}
