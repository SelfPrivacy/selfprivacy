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
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
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
  bool _isConfigurationVisible = false;

  @override
  Widget build(BuildContext context) {
    final keyStatus = context.watch<RecoveryKeyCubit>().state;

    List<Widget> widgets = [];

    if (keyStatus.exists) {
      widgets = [
        RecoveryKeyStatusCard(isValid: keyStatus.isValid),
        RecoveryKeyInformation(state: keyStatus),
        ...widgets,
      ];

      if (_isConfigurationVisible) {
        widgets = [
          ...widgets,
          const RecoveryKeyConfiguration(),
        ];
      }

      if (!_isConfigurationVisible) {
        if (keyStatus.isValid) {
          widgets = [
            ...widgets,
            const SizedBox(height: 16),
            BrandButton.text(
              title: 'recovery_key.key_replace_button'.tr(),
              onPressed: () {
                setState(() {
                  _isConfigurationVisible = true;
                });
              },
            ),
          ];
        } else {
          widgets = [
            ...widgets,
            const SizedBox(height: 16),
            FilledButton(
              title: 'recovery_key.key_replace_button'.tr(),
              onPressed: () {
                setState(() {
                  _isConfigurationVisible = true;
                });
              },
            ),
          ];
        }
      }
    }

    if (!keyStatus.exists) {
      widgets = [
        ...widgets,
        const RecoveryKeyConfiguration(),
      ];
    }

    return Column(children: widgets);
  }
}

class RecoveryKeyStatusCard extends StatelessWidget {
  const RecoveryKeyStatusCard({required this.isValid, Key? key})
      : super(key: key);

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return BrandCards.filled(
      child: ListTile(
        title: isValid
            ? Text(
                'recovery_key.key_valid'.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
            : Text(
                'recovery_key.key_invalid'.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
              ),
        leading: isValid
            ? Icon(
                Icons.check_circle_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              )
            : Icon(
                Icons.cancel_outlined,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
        tileColor: isValid
            ? Theme.of(context).colorScheme.surfaceVariant
            : Theme.of(context).colorScheme.errorContainer,
      ),
    );
  }
}

class RecoveryKeyInformation extends StatelessWidget {
  const RecoveryKeyInformation({required this.state, Key? key})
      : super(key: key);

  final RecoveryKeyState state;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 8.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.expiresAt != null)
          Padding(
            padding: padding,
            child: Text(
              'recovery_key.key_valid_until'.tr(
                args: [state.expiresAt!.toIso8601String()],
              ),
            ),
          ),
        if (state.usesLeft != null)
          Padding(
            padding: padding,
            child: Text(
              'recovery_key.key_valid_for'.tr(
                args: [state.usesLeft!.toString()],
              ),
            ),
          ),
        if (state.generatedAt != null)
          Padding(
            padding: padding,
            child: Text(
              'recovery_key.key_creation_date'.tr(
                args: [state.generatedAt!.toIso8601String()],
              ),
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }
}

class RecoveryKeyConfiguration extends StatefulWidget {
  const RecoveryKeyConfiguration({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecoveryKeyConfigurationState();
}

class _RecoveryKeyConfigurationState extends State<RecoveryKeyConfiguration> {
  bool _isAmountToggled = false;
  bool _isExpirationToggled = false;

  bool _isAmountError = false;
  bool _isExpirationError = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  bool _isDateSelected = false;

  @override
  Widget build(BuildContext context) {
    if (_isDateSelected) {
      _expirationController.text = _selectedDate.toIso8601String();
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text('recovery_key.key_amount_toggle'.tr()),
            Switch(
              value: _isAmountToggled,
              onChanged: (bool toogled) {
                setState(
                  () {
                    _isAmountToggled = toogled;
                    _isExpirationToggled = _isExpirationToggled;
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          enabled: _isAmountToggled,
          controller: _amountController,
          decoration: InputDecoration(
              errorText: _isAmountError ? ' ' : null,
              labelText: 'recovery_key.key_amount_field_title'.tr()),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ], // Only numbers can be entered
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text('recovery_key.key_duedate_toggle'.tr()),
            Switch(
              value: _isExpirationToggled,
              onChanged: (bool toogled) {
                setState(
                  () {
                    _isAmountToggled = _isAmountToggled;
                    _isExpirationToggled = toogled;
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          enabled: _isExpirationToggled,
          controller: _expirationController,
          onTap: () {
            _selectDate(context);
          },
          decoration: InputDecoration(
              errorText: _isExpirationError ? ' ' : null,
              labelText: 'recovery_key.key_duedate_field_title'.tr()),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ], // Only numbers can be entered
        ),
        const SizedBox(height: 16),
        FilledButton(
          title: 'recovery_key.key_receive_button'.tr(),
          onPressed: () {
            if (_isExpirationToggled && _expirationController.text.isEmpty) {
              setState(() {
                _isExpirationError = true;
                _isAmountError = false;
                _isAmountToggled = _isAmountToggled;
                _isExpirationToggled = _isExpirationToggled;
              });
              return;
            } else if (_isAmountToggled && _amountController.text.isEmpty) {
              setState(() {
                _isAmountError = true;
                _isExpirationError = false;
                _isAmountToggled = _isAmountToggled;
                _isExpirationToggled = _isExpirationToggled;
              });
              return;
            } else {
              setState(() {
                _isAmountError = false;
                _isExpirationError = false;
                _isAmountToggled = _isAmountToggled;
                _isExpirationToggled = _isExpirationToggled;
              });

              Navigator.of(context).push(
                materialRoute(
                  const RecoveryKeyReceiving(recoveryKey: ''), // TO DO
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 50));

    if (selected != null && selected != _selectedDate) {
      setState(
        () {
          _selectedDate = selected;
          _isDateSelected = true;
        },
      );
    }

    return _selectedDate;
  }
}
