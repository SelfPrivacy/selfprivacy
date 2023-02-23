import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

class RecoveryConfirmBackblaze extends StatelessWidget {
  const RecoveryConfirmBackblaze({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (final BuildContext context) => BackblazeFormCubit(appConfig),
      child: Builder(
        builder: (final BuildContext context) {
          final FormCubitState formCubitState =
              context.watch<BackblazeFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.confirm_backblaze'.tr(),
            heroSubtitle: 'recovering.confirm_backblaze_description'.tr(),
            hasBackButton: true,
            onBackButtonPressed: () {
              Navigator.of(context).popUntil((final route) => route.isFirst);
            },
            hasFlashButton: false,
            children: [
              CubitFormTextField(
                formFieldCubit: context.read<BackblazeFormCubit>().keyId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'KeyID',
                ),
              ),
              const SizedBox(height: 16),
              CubitFormTextField(
                formFieldCubit:
                    context.read<BackblazeFormCubit>().applicationKey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Master Application Key',
                ),
              ),
              const SizedBox(height: 16),
              BrandButton.rised(
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<BackblazeFormCubit>().trySubmit(),
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
                            fileName: 'how_backblaze',
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
