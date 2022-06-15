import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/hetzner_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

class RecoveryHetznerConnected extends StatelessWidget {
  const RecoveryHetznerConnected({final super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (final BuildContext context) => HetznerFormCubit(appConfig),
      child: Builder(
        builder: (final BuildContext context) {
          final FormCubitState formCubitState =
              context.watch<HetznerFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.hetzner_connected'.tr(),
            heroSubtitle: 'recovering.hetzner_connected_description'.tr(
              args: [appConfig.state.serverDomain?.domainName ?? 'your domain'],
            ),
            hasBackButton: true,
            hasFlashButton: false,
            onBackButtonPressed:
                context.read<ServerInstallationCubit>().revertRecoveryStep,
            children: [
              CubitFormTextField(
                formFieldCubit: context.read<HetznerFormCubit>().apiKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'recovering.hetzner_connected_placeholder'.tr(),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                title: 'more.continue'.tr(),
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<HetznerFormCubit>().trySubmit(),
              ),
              const SizedBox(height: 16),
              BrandButton.text(
                title: 'initializing.how'.tr(),
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
                            fileName: 'how_hetzner',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
