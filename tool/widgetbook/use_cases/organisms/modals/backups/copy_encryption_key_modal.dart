import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/copy_encryption_key_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';

import '../../../../preparation.dart';

@UseCase(
  name: 'Hidden key',
  type: CopyEncryptionKeyModal,
  path: '[Organisms]/modals/backups',
)
Widget copyEncryptionKeyModalHiddenKey(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('CopyEncryptionKeyModal/Hidden key'),
      id: 'CopyEncryptionKeyModal/Hidden key',
      variant: 'Hidden key',
      host: PreviewHost.sheet,
      width: 560,
      height: 600,
      builder:
          (final context, final fixtures, final controller, final update) =>
              CopyEncryptionKeyModal(scrollController: controller),
    );

@UseCase(
  name: 'Missing key',
  type: CopyEncryptionKeyModal,
  path: '[Organisms]/modals/backups',
)
Widget copyEncryptionKeyModalMissingKey(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('CopyEncryptionKeyModal/Missing key'),
      id: 'CopyEncryptionKeyModal/Missing key',
      variant: 'Missing key',
      host: PreviewHost.sheet,
      width: 560,
      height: 600,
      builder:
          (final context, final fixtures, final controller, final update) =>
              CopyEncryptionKeyModal(scrollController: controller),
    );

@UseCase(
  name: 'Revealed key',
  type: CopyEncryptionKeyModal,
  path: '[Organisms]/modals/backups',
)
Widget copyEncryptionKeyModalRevealedKey(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('CopyEncryptionKeyModal/Revealed key'),
      id: 'CopyEncryptionKeyModal/Revealed key',
      variant: 'Revealed key',
      prepare: PreviewAction.reveal,
      host: PreviewHost.sheet,
      width: 560,
      height: 600,
      builder:
          (final context, final fixtures, final controller, final update) =>
              CopyEncryptionKeyModal(scrollController: controller),
    );

@UseCase(
  name: 'Copied',
  type: CopyEncryptionKeyModal,
  path: '[Organisms]/modals/backups',
)
Widget copyEncryptionKeyModalCopied(final BuildContext context) => CatalogCase(
  key: const ValueKey('CopyEncryptionKeyModal/Copied'),
  id: 'CopyEncryptionKeyModal/Copied',
  variant: 'Copied',
  prepare: PreviewAction.copyKey,
  host: PreviewHost.sheet,
  width: 560,
  height: 600,
  builder: (final context, final fixtures, final controller, final update) =>
      CopyEncryptionKeyModal(scrollController: controller),
);
