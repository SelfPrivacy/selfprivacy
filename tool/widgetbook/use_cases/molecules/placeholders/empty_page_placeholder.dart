import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Empty',
  type: EmptyPagePlaceholder,
  path: '[Molecules]/placeholders',
)
Widget emptyPagePlaceholderEmpty(final BuildContext context) => CatalogCase(
  key: const ValueKey('EmptyPagePlaceholder/Empty'),
  id: 'EmptyPagePlaceholder/Empty',
  variant: 'Empty',
  host: PreviewHost.viewport,
  width: 560,
  height: 500,
  builder: (final context, final fixtures, final controller, final update) =>
      const EmptyPagePlaceholder(
        title: 'No backups yet',
        iconData: Icons.backup_outlined,
        description: null,
        showReadyCard: false,
      ),
);

@UseCase(
  name: 'Description',
  type: EmptyPagePlaceholder,
  path: '[Molecules]/placeholders',
)
Widget emptyPagePlaceholderDescription(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('EmptyPagePlaceholder/Description'),
      id: 'EmptyPagePlaceholder/Description',
      variant: 'Description',
      host: PreviewHost.viewport,
      width: 560,
      height: 500,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const EmptyPagePlaceholder(
                title: 'No backups yet',
                iconData: Icons.backup_outlined,
                description: 'Create your first backup to protect your files.',
                showReadyCard: false,
              ),
    );

@UseCase(
  name: 'Not configured',
  type: EmptyPagePlaceholder,
  path: '[Molecules]/placeholders',
)
Widget emptyPagePlaceholderNotConfigured(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('EmptyPagePlaceholder/Not configured'),
      id: 'EmptyPagePlaceholder/Not configured',
      variant: 'Not configured',
      host: PreviewHost.viewport,
      width: 560,
      height: 500,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const EmptyPagePlaceholder(
                title: 'No backups yet',
                iconData: Icons.backup_outlined,
                description: 'Create your first backup to protect your files.',
                showReadyCard: true,
              ),
    );
