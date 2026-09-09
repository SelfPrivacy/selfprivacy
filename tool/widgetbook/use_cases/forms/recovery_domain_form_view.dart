import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/recovery_domain_form.dart';
import 'package:selfprivacy/ui/forms/recovery_domain_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: RecoveryDomainFormView, path: '[Forms]')
Widget recoveryDomainFormViewEmpty(final BuildContext context) =>
    _example('Empty');

@UseCase(name: 'Required', type: RecoveryDomainFormView, path: '[Forms]')
Widget recoveryDomainFormViewRequired(final BuildContext context) =>
    _example('Required');

@UseCase(name: 'Ready', type: RecoveryDomainFormView, path: '[Forms]')
Widget recoveryDomainFormViewReady(final BuildContext context) =>
    _example('Ready');

@UseCase(name: 'Not found', type: RecoveryDomainFormView, path: '[Forms]')
Widget recoveryDomainFormViewNotFound(final BuildContext context) =>
    _example('Not found');

@UseCase(name: 'Submitting', type: RecoveryDomainFormView, path: '[Forms]')
Widget recoveryDomainFormViewSubmitting(final BuildContext context) =>
    _example('Submitting');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('RecoveryDomainFormView/$variant'),
  id: 'RecoveryDomainFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<RecoveryDomainForm>(
        create: (final scope) {
          final form = RecoveryDomainForm(
            validateDomain: (_) async => variant != 'Not found',
            onSubmit: (_) => scope.submit(variant),
          );
          scope.onDispose(form.dispose);
          prepareForm(form.form, variant, {'domain': 'example.org'});
          if (['Not found', 'Submitting'].contains(variant)) {
            unawaited(form.submit());
          }
          return form;
        },
        builder: (final context, final form) =>
            RecoveryDomainFormView(recoveryDomainForm: form),
      ),
);
