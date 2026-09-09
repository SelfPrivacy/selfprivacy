import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/backblaze_form.dart';
import 'package:selfprivacy/ui/forms/backblaze_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: BackblazeFormView, path: '[Forms]')
Widget backblazeFormViewEmpty(final BuildContext context) => _example('Empty');

@UseCase(name: 'Required', type: BackblazeFormView, path: '[Forms]')
Widget backblazeFormViewRequired(final BuildContext context) =>
    _example('Required');

@UseCase(name: 'Ready', type: BackblazeFormView, path: '[Forms]')
Widget backblazeFormViewReady(final BuildContext context) => _example('Ready');

@UseCase(name: 'Checking', type: BackblazeFormView, path: '[Forms]')
Widget backblazeFormViewChecking(final BuildContext context) =>
    _example('Checking');

@UseCase(name: 'Rejected', type: BackblazeFormView, path: '[Forms]')
Widget backblazeFormViewRejected(final BuildContext context) =>
    _example('Rejected');

@UseCase(name: 'Unavailable', type: BackblazeFormView, path: '[Forms]')
Widget backblazeFormViewUnavailable(final BuildContext context) =>
    _example('Unavailable');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('BackblazeFormView/$variant'),
  id: 'BackblazeFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<BackblazeForm>(
        create: (final scope) {
          final form = BackblazeForm(
            validateCredentials: (_) => scope.check(variant),
            onSubmit: (_) => scope.submit(variant),
          );
          scope.onDispose(form.dispose);
          final inputVariant = variant == 'Porkbun empty'
              ? 'Empty'
              : variant == 'Porkbun required'
              ? 'Required'
              : variant;
          prepareForm(form.form, inputVariant, {
            'keyId': 'catalog-key-id',
            'applicationKey': 'catalog-application-key',
          });
          if (['Checking', 'Rejected', 'Unavailable'].contains(variant)) {
            unawaited(form.submit());
          }
          return form;
        },
        builder: (final context, final form) =>
            BackblazeFormView(backblazeForm: form),
      ),
);
