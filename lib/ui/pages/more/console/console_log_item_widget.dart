import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/ui/pages/more/console/console_log_item_dialog.dart';

extension on ConsoleLog {
  Color resolveColor(final BuildContext context) =>
      isError
          ? Theme.of(context).colorScheme.error
          : switch (this) {
            (final RestApiRequestConsoleLog _) =>
              Theme.of(context).colorScheme.secondary,
            (final RestApiResponseConsoleLog _) =>
              Theme.of(context).colorScheme.primary,
            (final GraphQlRequestConsoleLog _) =>
              Theme.of(context).colorScheme.secondary,
            (final GraphQlResponseConsoleLog _) =>
              Theme.of(context).colorScheme.tertiary,
            (final ManualConsoleLog _) =>
              Theme.of(context).colorScheme.tertiary,
          };

  IconData resolveIcon() => switch (this) {
    (final RestApiRequestConsoleLog _) => Icons.upload_outlined,
    (final RestApiResponseConsoleLog _) => Icons.download_outlined,
    (final GraphQlRequestConsoleLog _) => Icons.arrow_circle_up_outlined,
    (final GraphQlResponseConsoleLog _) => Icons.arrow_circle_down_outlined,
    (final ManualConsoleLog _) => Icons.read_more_outlined,
  };
}

class ConsoleLogItemWidget extends StatelessWidget {
  const ConsoleLogItemWidget({required this.log, super.key});

  final ConsoleLog log;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: ListTile(
      dense: true,
      title: Text.rich(
        TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '${log.timeString}: ',
              style: const TextStyle(
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            TextSpan(
              text: log.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      subtitle: Text(log.content, overflow: TextOverflow.ellipsis, maxLines: 3),
      leading: Icon(log.resolveIcon()),
      iconColor: log.resolveColor(context),
      onTap:
          () => showDialog(
            context: context,
            builder:
                (final BuildContext context) => ConsoleItemDialog(log: log),
          ),
    ),
  );
}
