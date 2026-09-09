import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/dialog_action_button.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: DialogActionButton, path: '[Atoms]/buttons')
Widget dialogActionButtonDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('DialogActionButton/Default'),
  id: 'DialogActionButton/Default',
  variant: 'Default',
  host: PreviewHost.dialog,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      AlertDialog(
        title: const Text('Confirm action'),
        actions: [
          DialogActionButton(
            text: 'Confirm',
            isRed: false,
            onPressed: () => catalogActions.record('Confirmed'),
          ),
        ],
      ),
);

@UseCase(name: 'Destructive', type: DialogActionButton, path: '[Atoms]/buttons')
Widget dialogActionButtonDestructive(final BuildContext context) => CatalogCase(
  key: const ValueKey('DialogActionButton/Destructive'),
  id: 'DialogActionButton/Destructive',
  variant: 'Destructive',
  host: PreviewHost.dialog,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      AlertDialog(
        title: const Text('Confirm action'),
        actions: [
          DialogActionButton(
            text: 'Confirm',
            isRed: true,
            onPressed: () => catalogActions.record('Confirmed'),
          ),
        ],
      ),
);
