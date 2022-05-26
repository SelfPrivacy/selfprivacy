import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/recovery_key/recovery_key_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key_receiving.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class RecoveryKey extends StatefulWidget {
  const RecoveryKey({Key? key}) : super(key: key);

  @override
  State<RecoveryKey> createState() => _RecoveryKeyState();
}

class _RecoveryKeyState extends State<RecoveryKey> {
  @override
  Widget build(BuildContext context) {
    var keyStatus = context.watch<RecoveryKeyCubit>().state;

    final List<Widget> widgets;
    final String? subtitle =
        keyStatus.exists ? null : 'recovery_key.key_main_description'.tr();
    switch (keyStatus.loadingStatus) {
      case LoadingStatus.refreshing:
        widgets = [
          const Icon(Icons.refresh_outlined),
          const SizedBox(height: 18),
          BrandText(
            'recovery_key.key_synchronizing'.tr(),
            type: TextType.h1,
          ),
        ];
        break;
      case LoadingStatus.success:
        widgets = [
          const RecoveryKeyContent(),
        ];
        break;
      case LoadingStatus.uninitialized:
      case LoadingStatus.error:
        widgets = [
          const Icon(Icons.sentiment_dissatisfied_outlined),
          const SizedBox(height: 18),
          BrandText(
            'recovery_key.key_connection_error'.tr(),
            type: TextType.h1,
          ),
        ];
        break;
    }

    return BrandHeroScreen(
      heroTitle: 'recovery_key.key_main_header'.tr(),
      heroSubtitle: subtitle,
      hasBackButton: true,
      hasFlashButton: false,
      children: widgets,
    );
  }
}

class RecoveryKeyContent extends StatefulWidget {
  const RecoveryKeyContent({Key? key}) : super(key: key);

  @override
  State<RecoveryKeyContent> createState() => _RecoveryKeyContentState();
}

class _RecoveryKeyContentState extends State<RecoveryKeyContent> {
  bool _isAmountToggled = true;
  bool _isExpirationToggled = true;
  bool _isConfigurationVisible = false;

  final _amountController = TextEditingController();
  final _expirationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var keyStatus = context.read<RecoveryKeyCubit>().state;
    _isConfigurationVisible = !keyStatus.exists;

    List<Widget> widgets = [];

    if (keyStatus.exists) {
      if (keyStatus.isValid) {
        widgets = [
          BrandCards.filled(
            child: ListTile(
              title: Text('recovery_key.key_valid'.tr()),
              leading: const Icon(Icons.check_circle_outlined),
              tileColor: Colors.lightGreen,
            ),
          ),
          ...widgets
        ];
      } else {
        widgets = [
          BrandCards.filled(
            child: ListTile(
              title: Text('recovery_key.key_invalid'.tr()),
              leading: const Icon(Icons.cancel_outlined),
              tileColor: Colors.redAccent,
            ),
          ),
          ...widgets
        ];
      }

      if (keyStatus.expiresAt != null && !_isConfigurationVisible) {
        widgets = [
          ...widgets,
          const SizedBox(height: 18),
          Text(
            'recovery_key.key_valid_until'.tr(
              args: [keyStatus.expiresAt!.toIso8601String()],
            ),
          )
        ];
      }

      if (keyStatus.usesLeft != null && !_isConfigurationVisible) {
        widgets = [
          ...widgets,
          const SizedBox(height: 18),
          Text(
            'recovery_key.key_valid_for'.tr(
              args: [keyStatus.usesLeft!.toString()],
            ),
          )
        ];
      }

      if (keyStatus.generatedAt != null && !_isConfigurationVisible) {
        widgets = [
          ...widgets,
          const SizedBox(height: 18),
          Text(
            'recovery_key.key_creation_date'.tr(
              args: [keyStatus.generatedAt!.toIso8601String()],
            ),
          )
        ];
      }

      if (!_isConfigurationVisible) {
        if (keyStatus.isValid) {
          widgets = [
            ...widgets,
            const SizedBox(height: 18),
            BrandButton.text(
              title: 'recovery_key.key_replace_button'.tr(),
              onPressed: () => _isConfigurationVisible = true,
            ),
          ];
        } else {
          widgets = [
            ...widgets,
            const SizedBox(height: 18),
            FilledButton(
              title: 'recovery_key.key_replace_button'.tr(),
              onPressed: () => _isConfigurationVisible = true,
            ),
          ];
        }
      }
    }

    if (_isConfigurationVisible) {
      widgets = [
        ...widgets,
        const SizedBox(height: 18),
        Row(
          children: [
            Text('key_amount_toggle'.tr()),
            Switch(
              value: _isAmountToggled,
              onChanged: (bool toogled) => _isAmountToggled = toogled,
            ),
          ],
        ),
        const SizedBox(height: 18),
        TextField(
          enabled: _isAmountToggled,
          controller: _amountController,
          decoration: InputDecoration(
              labelText: 'recovery_key.key_amount_field_title'.tr()),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ], // Only numbers can be entered
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Text('key_duedate_toggle'.tr()),
            Switch(
              value: _isExpirationToggled,
              onChanged: (bool toogled) => _isExpirationToggled = toogled,
            ),
          ],
        ),
        const SizedBox(height: 18),
        TextField(
          enabled: _isExpirationToggled,
          controller: _expirationController,
          decoration: InputDecoration(
              labelText: 'recovery_key.key_duedate_field_title'.tr()),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ], // Only numbers can be entered
        ),
        const SizedBox(height: 18),
        FilledButton(
          title: 'recovery_key.key_receive_button'.tr(),
          disabled:
              (_isExpirationToggled && _expirationController.text.isEmpty) ||
                  (_isAmountToggled && _amountController.text.isEmpty),
          onPressed: () {
            Navigator.of(context).push(
              materialRoute(
                const RecoveryKeyReceiving(recoveryKey: ''), // TO DO
              ),
            );
          },
        ),
      ];
    }

    return Column(children: widgets);
  }
}
