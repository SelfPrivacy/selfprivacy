import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/ssh_key_form.dart';
import 'package:selfprivacy/ui/forms/ssh_key_form_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../fixtures/constants.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: SshKeyFormView, path: '[Forms]')
Widget sshKeyFormViewEmpty(final BuildContext context) => _example('Empty');

@UseCase(name: 'Required', type: SshKeyFormView, path: '[Forms]')
Widget sshKeyFormViewRequired(final BuildContext context) =>
    _example('Required');

@UseCase(name: 'Valid', type: SshKeyFormView, path: '[Forms]')
Widget sshKeyFormViewValid(final BuildContext context) => _example('Valid');

@UseCase(name: 'Invalid', type: SshKeyFormView, path: '[Forms]')
Widget sshKeyFormViewInvalid(final BuildContext context) => _example('Invalid');

@UseCase(name: 'Duplicate', type: SshKeyFormView, path: '[Forms]')
Widget sshKeyFormViewDuplicate(final BuildContext context) =>
    _example('Duplicate');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('SshKeyFormView/$variant'),
  id: 'SshKeyFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<SshKeyForm>(
        create: (final scope) {
          final form = SshKeyForm(
            onSubmit: (_) => scope.submit(variant),
            existingKeys: variant == 'Duplicate' ? [demoKey] : [],
          );
          scope.onDispose(form.form.dispose);
          prepareForm(form.form, variant, {
            'key': variant == 'Invalid' ? 'not an SSH key' : demoKey,
          });
          return form;
        },
        builder: (final context, final form) =>
            SshKeyFormView(sshKeyForm: form),
      ),
);
