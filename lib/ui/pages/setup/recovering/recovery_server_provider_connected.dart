import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/server_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoveryServerProviderConnected extends StatelessWidget {
  const RecoveryServerProviderConnected({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (final BuildContext context) =>
          ServerProviderFormCubit(appConfig),
      child: Builder(
        builder: (final BuildContext context) => BrandHeroScreen(
          heroTitle: 'recovering.provider_connected'.tr(
            args: [
              appConfig.state.serverDetails?.provider.displayName ??
                  'Server Provider',
            ],
          ),
          heroSubtitle: 'recovering.provider_connected_description'.tr(
            args: [appConfig.state.serverDomain?.domainName ?? 'your domain'],
          ),
          hasBackButton: true,
          hasFlashButton: false,
          ignoreBreakpoints: true,
          hasSupportDrawer: true,
          onBackButtonPressed: () {
            Navigator.of(context).popUntil((final route) => route.isFirst);
          },
          children: [
            CubitFormTextField(
              autofocus: true,
              formFieldCubit: context.read<ServerProviderFormCubit>().apiKey,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'recovering.provider_connected_placeholder'.tr(
                  args: [
                    appConfig.state.serverDetails?.provider.displayName ??
                        'Server Provider',
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            BrandButton.filled(
              onPressed: () =>
                  context.read<ServerProviderFormCubit>().trySubmit(),
              child: Text('basis.continue'.tr()),
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (final context) => BrandButton.text(
                title: 'initializing.how'.tr(),
                onPressed: () => context.read<SupportSystemCubit>().showArticle(
                      article: 'how_hetzner',
                      context: context,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
