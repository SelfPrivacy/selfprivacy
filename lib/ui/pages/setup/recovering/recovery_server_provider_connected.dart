import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/server_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoveryServerProviderConnected extends StatelessWidget {
  const RecoveryServerProviderConnected({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    final displayName =
        appConfig.state.serverDetails?.provider.displayName ??
        'Server Provider';

    final supportArticle =
        appConfig.state.serverDetails?.provider.supportArticle ?? '';

    if (appConfig.state.serverDetails?.provider == ServerProviderType.unknown) {
      return BrandHeroScreen(
        heroTitle: 'recovering.server_provider_unknown'.tr(),
        heroSubtitle: 'recovering.server_provider_unknown_description'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        ignoreBreakpoints: true,
        onBackButtonPressed: () {
          Navigator.of(context).popUntil((final route) => route.isFirst);
        },
        children: [
          BrandButton.filled(
            title: 'basis.continue'.tr(),
            onPressed:
                () =>
                    context
                        .read<ServerInstallationCubit>()
                        .skipSettingServerProviderKey(),
          ),
        ],
      );
    }

    return BlocProvider(
      create:
          (final BuildContext context) => ServerProviderFormCubit(appConfig),
      child: Builder(
        builder:
            (final BuildContext context) => BrandHeroScreen(
              heroTitle: 'recovering.provider_connected'.tr(
                args: [displayName],
              ),
              heroSubtitle: 'recovering.provider_connected_description'.tr(
                args: [
                  appConfig.state.serverDomain?.domainName ?? 'your domain',
                ],
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
                  formFieldCubit:
                      context.read<ServerProviderFormCubit>().apiKey,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'recovering.provider_connected_placeholder'.tr(
                      args: [displayName],
                    ),
                  ),
                ),
                const Gap(16),
                BrandButton.filled(
                  onPressed:
                      () => context.read<ServerProviderFormCubit>().trySubmit(),
                  child: Text('basis.continue'.tr()),
                ),
                const Gap(16),
                Builder(
                  builder:
                      (final context) => BrandButton.text(
                        title: 'initializing.how'.tr(),
                        onPressed:
                            () =>
                                context.read<SupportSystemCubit>().showArticle(
                                  article: supportArticle,
                                  context: context,
                                ),
                      ),
                ),
                const Gap(16),
                BrandButton.text(
                  title: 'recovering.login_later'.tr(),
                  onPressed:
                      () =>
                          context
                              .read<ServerInstallationCubit>()
                              .skipSettingServerProviderKey(),
                ),
              ],
            ),
      ),
    );
  }
}
