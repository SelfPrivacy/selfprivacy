import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

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
            heroTitle: 'recovering.provider_connected'.tr(args: ['Backblaze']),
            heroSubtitle: 'recovering.provider_connected_description'.tr(
              args: ['Backblaze'],
            ),
            hasBackButton: true,
            ignoreBreakpoints: true,
            hasSupportDrawer: true,
            onBackButtonPressed: () {
              Navigator.of(context).popUntil((final route) => route.isFirst);
            },
            hasFlashButton: false,
            children: [
              CubitFormTextField(
                autofocus: true,
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
              BrandButton.filled(
                onPressed:
                    formCubitState.isSubmitting
                        ? null
                        : () => context.read<BackblazeFormCubit>().trySubmit(),
                title: 'basis.connect'.tr(),
              ),
              const SizedBox(height: 16),
              Builder(
                builder:
                    (final context) => BrandButton.text(
                      onPressed:
                          () => context.read<SupportSystemCubit>().showArticle(
                            article: 'how_backblaze',
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
