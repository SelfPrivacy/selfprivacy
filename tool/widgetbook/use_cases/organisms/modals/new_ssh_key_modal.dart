import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/organisms/modals/new_ssh_key_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

import '../../../preparation.dart';

@UseCase(name: 'Empty', type: NewSshKeyModal, path: '[Organisms]/modals')
Widget newSshKeyModalEmpty(final BuildContext context) => CatalogCase(
  key: const ValueKey('NewSshKeyModal/Empty'),
  id: 'NewSshKeyModal/Empty',
  variant: 'Empty',
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      NewSshKeyModal(
        user: const User.fake(login: 'alice'),
        scrollController: controller,
      ),
);

@UseCase(name: 'Valid key', type: NewSshKeyModal, path: '[Organisms]/modals')
Widget newSshKeyModalValidKey(final BuildContext context) => CatalogCase(
  key: const ValueKey('NewSshKeyModal/Valid key'),
  id: 'NewSshKeyModal/Valid key',
  variant: 'Valid key',
  prepare: PreviewAction.validKey,
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      NewSshKeyModal(
        user: const User.fake(login: 'alice'),
        scrollController: controller,
      ),
);

@UseCase(name: 'Invalid key', type: NewSshKeyModal, path: '[Organisms]/modals')
Widget newSshKeyModalInvalidKey(final BuildContext context) => CatalogCase(
  key: const ValueKey('NewSshKeyModal/Invalid key'),
  id: 'NewSshKeyModal/Invalid key',
  variant: 'Invalid key',
  prepare: PreviewAction.invalidKey,
  host: PreviewHost.sheet,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      NewSshKeyModal(
        user: const User.fake(login: 'alice'),
        scrollController: controller,
      ),
);
