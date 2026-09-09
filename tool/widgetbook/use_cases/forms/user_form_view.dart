import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/forms/user_form_view.dart';
import 'package:selfprivacy/ui/pages/users/new_user.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';
import '../../form_preview.dart';

@UseCase(name: 'Empty', type: UserFormView, path: '[Forms]')
Widget userFormViewEmpty(final BuildContext context) => _example('Empty');

@UseCase(name: 'Required', type: UserFormView, path: '[Forms]')
Widget userFormViewRequired(final BuildContext context) => _example('Required');

@UseCase(name: 'Ready', type: UserFormView, path: '[Forms]')
Widget userFormViewReady(final BuildContext context) => _example('Ready');

@UseCase(name: 'Edit', type: UserFormView, path: '[Forms]')
Widget userFormViewEdit(final BuildContext context) => _example('Edit');

@UseCase(name: 'Invalid login', type: UserFormView, path: '[Forms]')
Widget userFormViewInvalidLogin(final BuildContext context) =>
    _example('Invalid login');

@UseCase(name: 'Reserved login', type: UserFormView, path: '[Forms]')
Widget userFormViewReservedLogin(final BuildContext context) =>
    _example('Reserved login');

@UseCase(name: 'Taken login', type: UserFormView, path: '[Forms]')
Widget userFormViewTakenLogin(final BuildContext context) =>
    _example('Taken login');

@UseCase(name: 'Long login', type: UserFormView, path: '[Forms]')
Widget userFormViewLongLogin(final BuildContext context) =>
    _example('Long login');

@UseCase(name: 'Long display name', type: UserFormView, path: '[Forms]')
Widget userFormViewLongDisplayName(final BuildContext context) =>
    _example('Long display name');

@UseCase(name: 'Submitting', type: UserFormView, path: '[Forms]')
Widget userFormViewSubmitting(final BuildContext context) =>
    _example('Submitting');

CatalogCase _example(final String variant) => CatalogCase(
  key: ValueKey('UserFormView/$variant'),
  id: 'UserFormView/$variant',
  variant: variant,
  height: 900,
  builder: (final context, final fixtures, final controller, final update) =>
      FormPreview<UserForm>(
        create: (final scope) {
          final form = UserForm(
            initialUser: variant == 'Edit'
                ? const User.fake(
                    login: 'alice',
                    displayName: 'Alice',
                    directmemberof: ['sp.admins'],
                  )
                : null,
            isLoginRegistered: (final login) => login == 'existing_user',
            onSubmit: (_) => scope.submit(variant),
          );
          scope.onDispose(form.dispose);
          final login = switch (variant) {
            'Invalid login' => 'Invalid Name!',
            'Reserved login' => 'root',
            'Taken login' => 'existing_user',
            'Long login' => List.filled(40, 'a').join(),
            _ => 'alice',
          };
          prepareForm(form.form, variant, {
            'login': login,
            'displayName': variant == 'Long display name'
                ? List.filled(260, 'a').join()
                : 'Alice Example',
          });
          if (variant == 'Submitting') {
            unawaited(form.submit());
          }
          return form;
        },
        builder: (final context, final form) => UserFormView(
          userForm: form,
          domainName: 'example.org',
          groupsSelector: GroupsSelector(
            groupsControl:
                form.form.control(UserForm.groupsControlName)
                    as FormControl<List<String>>,
          ),
        ),
      ),
);
