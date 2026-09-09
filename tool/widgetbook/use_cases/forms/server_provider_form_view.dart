import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/server_provider_form.dart';
import 'package:selfprivacy/ui/forms/server_provider_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: ServerProviderFormView, path: '[Forms]')
Widget serverProviderFormViewEmpty(final BuildContext context) =>
    _example('Empty');

@UseCase(name: 'Required', type: ServerProviderFormView, path: '[Forms]')
Widget serverProviderFormViewRequired(final BuildContext context) =>
    _example('Required');

@UseCase(name: 'Ready', type: ServerProviderFormView, path: '[Forms]')
Widget serverProviderFormViewReady(final BuildContext context) =>
    _example('Ready');

@UseCase(name: 'Checking', type: ServerProviderFormView, path: '[Forms]')
Widget serverProviderFormViewChecking(final BuildContext context) =>
    _example('Checking');

@UseCase(name: 'Rejected', type: ServerProviderFormView, path: '[Forms]')
Widget serverProviderFormViewRejected(final BuildContext context) =>
    _example('Rejected');

@UseCase(name: 'Unavailable', type: ServerProviderFormView, path: '[Forms]')
Widget serverProviderFormViewUnavailable(final BuildContext context) =>
    _example('Unavailable');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('ServerProviderFormView/$variant'),
  id: 'ServerProviderFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<ServerProviderForm>(
        create: (final scope) {
          final form = ServerProviderForm(
            validateCredential: (_) => scope.check(variant),
            onSubmit: (_) => scope.submit(variant),
          );
          scope.onDispose(form.dispose);
          final inputVariant = variant == 'Porkbun empty'
              ? 'Empty'
              : variant == 'Porkbun required'
              ? 'Required'
              : variant;
          prepareForm(form.form, inputVariant, {
            'apiKey': 'catalog-server-api-token',
          });
          if (['Checking', 'Rejected', 'Unavailable'].contains(variant)) {
            unawaited(form.submit());
          }
          return form;
        },
        builder: (final context, final form) => ServerProviderFormView(
          serverProviderForm: form,
          fieldLabel: 'Hetzner API token',
          submitLabel: 'Connect',
        ),
      ),
);
