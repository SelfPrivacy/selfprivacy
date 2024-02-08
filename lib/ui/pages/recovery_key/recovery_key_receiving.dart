import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/recovery_key/recovery_key_bloc.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoveryKeyReceiving extends StatelessWidget {
  const RecoveryKeyReceiving({super.key});

  @override
  Widget build(final BuildContext context) {
    final recoveryKeyState = context.watch<RecoveryKeyBloc>().state;

    final String? recoveryKey = recoveryKeyState is RecoveryKeyCreating
        ? recoveryKeyState.recoveryKey
        : null;

    final String? error =
        recoveryKeyState is RecoveryKeyCreating ? recoveryKeyState.error : null;

    return BrandHeroScreen(
      heroTitle: 'recovery_key.key_main_header'.tr(),
      heroSubtitle: 'recovery_key.key_receiving_description'.tr(),
      hasBackButton: true,
      hasFlashButton: false,
      children: [
        const Divider(),
        const SizedBox(height: 16),
        if (recoveryKey == null && error == null)
          const Center(child: CircularProgressIndicator()),
        if (recoveryKey != null)
          Text(
            recoveryKey,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontFamily: 'RobotoMono',
                ),
            textAlign: TextAlign.center,
          ),
        if (error != null)
          Text(
            'recovery_key.generation_error'.tr(args: [error]),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontFamily: 'RobotoMono',
                  color: Theme.of(context).colorScheme.error,
                ),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        InfoBox(
          text: 'recovery_key.key_receiving_info'.tr(),
        ),
        const SizedBox(height: 16),
        BrandButton.filled(
          child: Text('recovery_key.key_receiving_done'.tr()),
          onPressed: () {
            context.read<RecoveryKeyBloc>().add(const ConsumedNewRecoveryKey());
            Navigator.of(context).popUntil((final route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
