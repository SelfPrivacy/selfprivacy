import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/molecules/cards/ssh_keys_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Empty', type: SshKeysCard, path: '[Molecules]/cards')
Widget sshKeysCardEmpty(final BuildContext context) => CatalogCase(
  key: const ValueKey('SshKeysCard/Empty'),
  id: 'SshKeysCard/Empty',
  variant: 'Empty',
  host: PreviewHost.content,
  width: 560,
  height: 440,
  builder: (final context, final fixtures, final controller, final update) =>
      const SshKeysCard(
        user: User.fake(login: 'alice', sshKeys: []),
      ),
);

@UseCase(name: 'Keys', type: SshKeysCard, path: '[Molecules]/cards')
Widget sshKeysCardKeys(final BuildContext context) => CatalogCase(
  key: const ValueKey('SshKeysCard/Keys'),
  id: 'SshKeysCard/Keys',
  variant: 'Keys',
  host: PreviewHost.content,
  width: 560,
  height: 440,
  builder: (final context, final fixtures, final controller, final update) =>
      const SshKeysCard(
        user: User.fake(login: 'alice', sshKeys: [demoKey]),
      ),
);

@UseCase(name: 'SSH disabled', type: SshKeysCard, path: '[Molecules]/cards')
Widget sshKeysCardSSHDisabled(final BuildContext context) => CatalogCase(
  key: const ValueKey('SshKeysCard/SSH disabled'),
  id: 'SshKeysCard/SSH disabled',
  variant: 'SSH disabled',
  host: PreviewHost.content,
  width: 560,
  height: 440,
  builder: (final context, final fixtures, final controller, final update) =>
      const SshKeysCard(
        user: User.fake(login: 'alice', sshKeys: [demoKey]),
      ),
);
