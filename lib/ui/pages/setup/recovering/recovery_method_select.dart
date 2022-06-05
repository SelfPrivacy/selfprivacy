import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_old_token.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class RecoveryMethodSelect extends StatelessWidget {
  const RecoveryMethodSelect({final super.key});

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        heroTitle: 'recovering.recovery_main_header'.tr(),
        heroSubtitle: 'recovering.method_select_description'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        children: [
          BrandCards.outlined(
            child: ListTile(
              title: Text(
                'recovering.method_select_other_device'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: const Icon(Icons.offline_share_outlined),
              onTap: () => context
                  .read<ServerInstallationCubit>()
                  .selectRecoveryMethod(ServerRecoveryMethods.newDeviceKey),
            ),
          ),
          const SizedBox(height: 16),
          BrandCards.outlined(
            child: ListTile(
              title: Text(
                'recovering.method_select_recovery_key'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: const Icon(Icons.password_outlined),
              onTap: () => context
                  .read<ServerInstallationCubit>()
                  .selectRecoveryMethod(ServerRecoveryMethods.recoveryKey),
            ),
          ),
          const SizedBox(height: 16),
          BrandButton.text(
            title: 'recovering.method_select_nothing'.tr(),
            onPressed: () => Navigator.of(context)
                .push(materialRoute(const RecoveryFallbackMethodSelect())),
          )
        ],
      );
}

class RecoveryFallbackMethodSelect extends StatelessWidget {
  const RecoveryFallbackMethodSelect({final super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocListener<ServerInstallationCubit, ServerInstallationState>(
        listener: (final context, final state) {
          if (state is ServerInstallationRecovery &&
              state.recoveryCapabilities ==
                  ServerRecoveryCapabilities.loginTokens &&
              state.currentStep != RecoveryStep.selecting) {
            Navigator.of(context).pop();
          }
        },
        child: BrandHeroScreen(
          heroTitle: 'recovering.recovery_main_header'.tr(),
          heroSubtitle: 'recovering.fallback_select_description'.tr(),
          hasBackButton: true,
          hasFlashButton: false,
          children: [
            BrandCards.outlined(
              child: ListTile(
                title: Text(
                  'recovering.fallback_select_token_copy'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: const Icon(Icons.vpn_key),
                onTap: () => Navigator.of(context).push(
                  materialRoute(
                    const RecoverByOldTokenInstruction(
                      instructionFilename: 'how_fallback_old',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BrandCards.outlined(
              child: ListTile(
                title: Text(
                  'recovering.fallback_select_root_ssh'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: const Icon(Icons.terminal),
                onTap: () => Navigator.of(context).push(
                  materialRoute(
                    const RecoverByOldTokenInstruction(
                      instructionFilename: 'how_fallback_ssh',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BrandCards.outlined(
              child: ListTile(
                title: Text(
                  'recovering.fallback_select_provider_console'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  'recovering.fallback_select_provider_console_hint'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                leading: const Icon(Icons.web),
                onTap: () => Navigator.of(context).push(
                  materialRoute(
                    const RecoverByOldTokenInstruction(
                      instructionFilename: 'how_fallback_terminal',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
