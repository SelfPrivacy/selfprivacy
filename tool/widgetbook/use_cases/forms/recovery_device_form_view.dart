import 'dart:async';

import 'package:bip39_mnemonic/bip39_mnemonic.dart' show Language, Mnemonic;
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';
import 'package:selfprivacy/ui/forms/recovery_device_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../fixtures/constants.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: RecoveryDeviceFormView, path: '[Forms]')
Widget recoveryDeviceFormViewEmpty(final BuildContext context) =>
    _example('Empty');

@UseCase(name: 'Required', type: RecoveryDeviceFormView, path: '[Forms]')
Widget recoveryDeviceFormViewRequired(final BuildContext context) =>
    _example('Required');

@UseCase(name: 'Recovery key', type: RecoveryDeviceFormView, path: '[Forms]')
Widget recoveryDeviceFormViewRecoveryKey(final BuildContext context) =>
    _example('Recovery key');

@UseCase(
  name: 'Invalid recovery key',
  type: RecoveryDeviceFormView,
  path: '[Forms]',
)
Widget recoveryDeviceFormViewInvalidRecoveryKey(final BuildContext context) =>
    _example('Invalid recovery key');

@UseCase(name: 'New device key', type: RecoveryDeviceFormView, path: '[Forms]')
Widget recoveryDeviceFormViewNewDeviceKey(final BuildContext context) =>
    _example('New device key');

@UseCase(
  name: 'Invalid device key',
  type: RecoveryDeviceFormView,
  path: '[Forms]',
)
Widget recoveryDeviceFormViewInvalidDeviceKey(final BuildContext context) =>
    _example('Invalid device key');

@UseCase(name: 'Old token', type: RecoveryDeviceFormView, path: '[Forms]')
Widget recoveryDeviceFormViewOldToken(final BuildContext context) =>
    _example('Old token');

@UseCase(name: 'Submitting', type: RecoveryDeviceFormView, path: '[Forms]')
Widget recoveryDeviceFormViewSubmitting(final BuildContext context) =>
    _example('Submitting');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('RecoveryDeviceFormView/$variant'),
  id: 'RecoveryDeviceFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<RecoveryDeviceForm>(
        create: (final scope) {
          final type = variant == 'Old token'
              ? RecoveryDeviceTokenType.oldToken
              : ['New device key', 'Invalid device key'].contains(variant)
              ? RecoveryDeviceTokenType.newDeviceKey
              : RecoveryDeviceTokenType.recoveryKey;
          final form = RecoveryDeviceForm(
            tokenType: type,
            onSubmit: (_) => scope.submit(variant),
          );
          scope.onDispose(form.dispose);
          final token = variant.startsWith('Invalid')
              ? 'not a valid mnemonic'
              : type == RecoveryDeviceTokenType.oldToken
              ? 'catalog-legacy-api-token'
              : type == RecoveryDeviceTokenType.newDeviceKey
              ? demoMnemonic
              : Mnemonic(
                  List<int>.generate(24, (final i) => i),
                  Language.english,
                ).sentence;
          prepareForm(form.form, variant, {'token': token});
          if (variant == 'Submitting') {
            unawaited(form.submit());
          }
          return form;
        },
        builder: (final context, final form) =>
            RecoveryDeviceFormView(recoveryDeviceForm: form),
      ),
);
