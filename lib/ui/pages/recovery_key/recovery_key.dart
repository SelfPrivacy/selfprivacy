import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/recovery_key/recovery_key_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/filled_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key_receiving.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

@RoutePage()
class RecoveryKeyPage extends StatefulWidget {
  const RecoveryKeyPage({super.key});

  @override
  State<RecoveryKeyPage> createState() => _RecoveryKeyPageState();
}

class _RecoveryKeyPageState extends State<RecoveryKeyPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecoveryKeyCubit>().load();
  }

  @override
  Widget build(final BuildContext context) {
    final RecoveryKeyState keyStatus = context.watch<RecoveryKeyCubit>().state;

    final List<Widget> widgets;
    String? subtitle =
        keyStatus.exists ? null : 'recovery_key.key_main_description'.tr();

    switch (keyStatus.loadingStatus) {
      case LoadingStatus.refreshing:
        subtitle = 'recovery_key.key_synchronizing'.tr();
        widgets = [
          const Center(child: CircularProgressIndicator()),
        ];
        break;
      case LoadingStatus.success:
        widgets = [
          const RecoveryKeyContent(),
        ];
        break;
      case LoadingStatus.uninitialized:
      case LoadingStatus.error:
        subtitle = 'recovery_key.key_connection_error'.tr();
        widgets = [
          const Icon(Icons.sentiment_dissatisfied_outlined),
        ];
        break;
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<RecoveryKeyCubit>().load();
      },
      child: BrandHeroScreen(
        heroTitle: 'recovery_key.key_main_header'.tr(),
        heroSubtitle: subtitle,
        hasBackButton: true,
        hasFlashButton: false,
        children: widgets,
      ),
    );
  }
}

class RecoveryKeyContent extends StatefulWidget {
  const RecoveryKeyContent({super.key});

  @override
  State<RecoveryKeyContent> createState() => _RecoveryKeyContentState();
}

class _RecoveryKeyContentState extends State<RecoveryKeyContent> {
  bool _isConfigurationVisible = false;

  @override
  Widget build(final BuildContext context) {
    final RecoveryKeyState keyStatus = context.watch<RecoveryKeyCubit>().state;

    return Column(
      children: [
        if (keyStatus.exists) RecoveryKeyStatusCard(isValid: keyStatus.isValid),
        const SizedBox(height: 16),
        if (keyStatus.exists && !_isConfigurationVisible)
          RecoveryKeyInformation(state: keyStatus),
        if (_isConfigurationVisible || !keyStatus.exists)
          const RecoveryKeyConfiguration(),
        const SizedBox(height: 16),
        if (!_isConfigurationVisible && keyStatus.isValid && keyStatus.exists)
          BrandButton.text(
            title: 'recovery_key.key_replace_button'.tr(),
            onPressed: () {
              setState(() {
                _isConfigurationVisible = true;
              });
            },
          ),
        if (!_isConfigurationVisible && !keyStatus.isValid && keyStatus.exists)
          BrandButton.filled(
            child: Text('recovery_key.key_replace_button'.tr()),
            onPressed: () {
              setState(() {
                _isConfigurationVisible = true;
              });
            },
          ),
      ],
    );
  }
}

class RecoveryKeyStatusCard extends StatelessWidget {
  const RecoveryKeyStatusCard({required this.isValid, super.key});

  final bool isValid;

  @override
  Widget build(final BuildContext context) => FilledCard(
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

class RecoveryKeyInformation extends StatelessWidget {
  const RecoveryKeyInformation({required this.state, super.key});

  final RecoveryKeyState state;

  @override
  Widget build(final BuildContext context) {
    const EdgeInsets padding =
        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.expiresAt != null)
            Padding(
              padding: padding,
              child: Text(
                'recovery_key.key_valid_until'.tr(
                  args: [DateFormat.yMMMMd().format(state.expiresAt!)],
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: state.isInvalidBecauseExpired
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onBackground,
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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: state.isInvalidBecauseUsed
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          if (state.generatedAt != null)
            Padding(
              padding: padding,
              child: Text(
                'recovery_key.key_creation_date'.tr(
                  args: [DateFormat.yMMMMd().format(state.generatedAt!)],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RecoveryKeyConfiguration extends StatefulWidget {
  const RecoveryKeyConfiguration({super.key});

  @override
  State<StatefulWidget> createState() => _RecoveryKeyConfigurationState();
}

class _RecoveryKeyConfigurationState extends State<RecoveryKeyConfiguration> {
  bool _isAmountToggled = false;
  bool _isExpirationToggled = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  bool _isAmountError = false;
  bool _isExpirationError = false;

  DateTime _selectedDate = DateTime.now();
  bool _isDateSelected = false;

  bool _isLoading = false;

  Future<void> _generateRecoveryToken() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final String token =
          await context.read<RecoveryKeyCubit>().generateRecoveryKey(
                numberOfUses: _isAmountToggled
                    ? int.tryParse(_amountController.text)
                    : null,
                expirationDate: _isExpirationToggled ? _selectedDate : null,
              );
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
      await Navigator.of(context).push(
        materialRoute(
          RecoveryKeyReceiving(recoveryKey: token), // TO DO
        ),
      );
    } on GenerationError catch (e) {
      setState(() {
        _isLoading = false;
      });
      getIt<NavigationService>().showSnackBar(
        'recovery_key.generation_error'.tr(args: [e.message]),
      );
      return;
    }
  }

  void _updateErrorStatuses() {
    final String amount = _amountController.text;
    final String expiration = _expirationController.text;

    print('amount: $amount');
    print('_isAmountToggled: $_isAmountToggled');
    print('_isExpirationToggled: $_isExpirationToggled');

    setState(() {
      if (!_isAmountToggled) {
        _isAmountError = false;
      } else if (amount.isEmpty) {
        _isAmountError = true;
      } else {
        final int? amountInt = int.tryParse(amount);
        _isAmountError = amountInt == null || amountInt <= 0;
      }

      if (!_isExpirationToggled) {
        _isExpirationError = false;
      } else if (expiration.isEmpty) {
        _isExpirationError = true;
      } else {
        _isExpirationError = _selectedDate.isBefore(DateTime.now());
      }
    });

    print('_isAmountError: $_isAmountError');
    print('_isExpirationError: $_isExpirationError');
  }

  @override
  Widget build(final BuildContext context) {
    if (_isDateSelected) {
      _expirationController.text = DateFormat.yMMMMd().format(_selectedDate);
    }

    _amountController.addListener(_updateErrorStatuses);
    _expirationController.addListener(_updateErrorStatuses);

    return Column(
      children: [
        SwitchListTile(
          value: _isAmountToggled,
          title: Text('recovery_key.key_amount_toggle'.tr()),
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (final bool toggled) {
            setState(
              () {
                _isAmountToggled = toggled;
              },
            );
            _updateErrorStatuses();
          },
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: _isAmountToggled
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Column(
            children: [
              const SizedBox(height: 8),
              TextField(
                textInputAction: TextInputAction.next,
                enabled: _isAmountToggled,
                controller: _amountController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _isAmountError ? ' ' : null,
                  labelText: 'recovery_key.key_amount_field_title'.tr(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
              const SizedBox(height: 8),
            ],
          ),
          secondChild: Container(),
        ),
        SwitchListTile(
          value: _isExpirationToggled,
          title: Text('recovery_key.key_duedate_toggle'.tr()),
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (final bool toggled) {
            setState(
              () {
                _isExpirationToggled = toggled;
              },
            );
            _updateErrorStatuses();
          },
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: _isExpirationToggled
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Column(
            children: [
              const SizedBox(height: 8),
              TextField(
                textInputAction: TextInputAction.next,
                enabled: _isExpirationToggled,
                controller: _expirationController,
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _isExpirationError ? ' ' : null,
                  labelText: 'recovery_key.key_duedate_field_title'.tr(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ], // Only numbers can be entered
              ),
            ],
          ),
          secondChild: Container(),
        ),
        const SizedBox(height: 16),
        BrandButton.filled(
          onPressed: !_isAmountError && !_isExpirationError && !_isLoading
              ? _generateRecoveryToken
              : null,
          child: Text('recovery_key.key_receive_button'.tr()),
        ),
      ],
    );
  }

  Future<DateTime> _selectDate(final BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
    );

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
