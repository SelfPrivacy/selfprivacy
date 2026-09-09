import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/drawers/progress_drawer.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'First step', type: ProgressDrawer, path: '[Organisms]/drawers')
Widget progressDrawerFirstStep(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProgressDrawer/First step'),
  id: 'ProgressDrawer/First step',
  variant: 'First step',
  host: PreviewHost.drawer,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      const ProgressDrawer(
        steps: ['providers.server', 'providers.domain', 'providers.backup'],
        currentStep: 0,
        constraints: BoxConstraints(maxHeight: 600),
        trailing: Text('SelfPrivacy'),
        title: 'Set up your server',
      ),
);

@UseCase(name: 'Middle step', type: ProgressDrawer, path: '[Organisms]/drawers')
Widget progressDrawerMiddleStep(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProgressDrawer/Middle step'),
  id: 'ProgressDrawer/Middle step',
  variant: 'Middle step',
  host: PreviewHost.drawer,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      const ProgressDrawer(
        steps: ['providers.server', 'providers.domain', 'providers.backup'],
        currentStep: 1,
        constraints: BoxConstraints(maxHeight: 600),
        trailing: Text('SelfPrivacy'),
        title: 'Set up your server',
      ),
);

@UseCase(name: 'Complete', type: ProgressDrawer, path: '[Organisms]/drawers')
Widget progressDrawerComplete(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProgressDrawer/Complete'),
  id: 'ProgressDrawer/Complete',
  variant: 'Complete',
  host: PreviewHost.drawer,
  width: 560,
  height: 650,
  builder: (final context, final fixtures, final controller, final update) =>
      const ProgressDrawer(
        steps: ['providers.server', 'providers.domain', 'providers.backup'],
        currentStep: 3,
        constraints: BoxConstraints(maxHeight: 600),
        trailing: Text('SelfPrivacy'),
        title: 'Set up your server',
      ),
);
