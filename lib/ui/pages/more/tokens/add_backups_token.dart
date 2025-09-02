import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

@RoutePage()
class AddBackupsTokenPage extends StatelessWidget {
  const AddBackupsTokenPage({super.key});

  @override
  Widget build(final BuildContext context) {
    void setBackupsProviderKey(
      final String keyId,
      final String applicationKey,
    ) {
      context.read<TokensBloc>().add(
        AddBackupsProviderCredential(
          BackupsCredential(
            keyId: keyId,
            applicationKey: applicationKey,
            provider: BackupsProviderType.backblaze,
          ),
        ),
      );
      context.maybePop();
    }

    return BlocProvider(
      create: (final context) => BackblazeFormCubit(setBackupsProviderKey),
      child: Builder(
        builder: (final context) {
          final formCubitState = context.watch<BackblazeFormCubit>().state;
          return BrandHeroScreen(
            heroTitle: 'initializing.connect_to_server_provider'.tr(
              namedArgs: {'provider': 'Backblaze'},
            ),
            hasBackButton: true,
            ignoreBreakpoints: true,
            hasSupportDrawer: true,
            hasFlashButton: false,
            children: [
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: context.read<BackblazeFormCubit>().keyId,
                scrollPadding: const EdgeInsets.only(bottom: 70),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'KeyID',
                ),
              ),
              const SizedBox(height: 16),
              CubitFormTextField(
                formFieldCubit:
                    context.read<BackblazeFormCubit>().applicationKey,
                scrollPadding: const EdgeInsets.only(bottom: 70),
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
              BrandButton.text(
                onPressed: () {
                  context.read<SupportSystemCubit>().showArticle(
                    article: 'how_backblaze',
                    context: context,
                  );
                  Scaffold.of(context).openEndDrawer();
                },
                title: 'initializing.how'.tr(),
              ),
            ],
          );
        },
      ),
    );
  }
}
