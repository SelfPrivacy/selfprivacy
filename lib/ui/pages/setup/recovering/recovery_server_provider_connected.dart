import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/provider_form_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

class RecoveryServerProviderConnected extends StatelessWidget {
  const RecoveryServerProviderConnected({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (final BuildContext context) => ProviderFormCubit(appConfig),
      child: Builder(
        builder: (final BuildContext context) {
          final FormCubitState formCubitState =
              context.watch<ProviderFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.server_provider_connected'.tr(),
            heroSubtitle: 'recovering.server_provider_connected_description'.tr(
              args: [appConfig.state.serverDomain?.domainName ?? 'your domain'],
            ),
            hasBackButton: true,
            hasFlashButton: false,
            onBackButtonPressed: () {
              Navigator.of(context).popUntil((final route) => route.isFirst);
            },
            children: [
              CubitFormTextField(
                formFieldCubit: context.read<ProviderFormCubit>().apiKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      'recovering.server_provider_connected_placeholder'.tr(),
                ),
              ),
              const SizedBox(height: 16),
              BrandButton.filled(
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<ProviderFormCubit>().trySubmit(),
                child: Text('basis.continue'.tr()),
              ),
              const SizedBox(height: 16),
              BrandButton.text(
                title: 'initializing.how'.tr(),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (final BuildContext context) => Padding(
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
            ],
          );
        },
      ),
    );
  }
}
