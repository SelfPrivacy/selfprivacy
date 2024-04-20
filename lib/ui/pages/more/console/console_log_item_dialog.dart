import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

extension on ConsoleLog {
  List<Widget> unwrapContent(final BuildContext context) => switch (this) {
        (final RestApiRequestConsoleLog log) => [
            if (log.method != null) _KeyValueRow('method', log.method),
            if (log.uri != null) _KeyValueRow('uri', log.uri.toString()),

            // headers bloc
            if (log.headers?.isNotEmpty ?? false) const _SectionRow('Headers'),
            ...?log.headers?.entries
                .map((final entry) => _KeyValueRow(entry.key, entry.value)),

            // data bloc
            const _SectionRow('Request data'),
            _DataRow(log.data?.toString()),
          ],
        (final RestApiResponseConsoleLog log) => [
            if (log.method != null) _KeyValueRow('method', log.method),
            if (log.uri != null) _KeyValueRow('uri', log.uri.toString()),
            if (log.statusCode != null)
              _KeyValueRow(
                'statusCode',
                log.statusCode.toString(),
              ),

            // data bloc
            const _SectionRow('Response data'),
            _DataRow(log.data?.toString()),
          ],
        (final GraphQlRequestConsoleLog log) => [
            // context
            const _SectionRow('Context'),
            _DataRow(log.context?.toString()),
            // data
            if (log.operation != null) const _SectionRow('Operation'),
            _DataRow(log.stringifiedOperation), // errors
            if (log.variables?.isNotEmpty ?? false)
              const _SectionRow('Variables'),
            ...?log.variables?.entries.map(
              (final entry) => _KeyValueRow(
                entry.key,
                '${entry.value}',
              ),
            ),
          ],
        (final GraphQlResponseConsoleLog log) => [
            // context
            const _SectionRow('Context'),
            _DataRow(log.context?.toString()),
            // data
            if (log.data != null) const _SectionRow('Data'),
            ...?log.data?.entries.map(
              (final entry) => _KeyValueRow(
                entry.key,
                '${entry.value}',
              ),
            ),
            // errors
            if (log.errors?.isNotEmpty ?? false) const _SectionRow('Errors'),
            ...?log.errors?.map(
              (final entry) => _KeyValueRow(
                entry.message,
                '${entry.locations}',
              ),
            ),
          ],
        (final ManualConsoleLog log) => [
            _DataRow(log.content),
          ],
      };
}

class ConsoleItemDialog extends StatelessWidget {
  const ConsoleItemDialog({
    required this.log,
    super.key,
  });

  final ConsoleLog log;

  @override
  Widget build(final BuildContext context) {
    final content = log.unwrapContent(context);

    return AlertDialog(
      scrollable: true,
      title: Text(log.title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              /// TODO(misterfourtytwo): maybe should add translations later
              const Text('logged at: '),
              SelectableText(
                log.timeString,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const Divider(),
          ...content,
        ],
      ),
      actions: [
        // A button to copy the request to the clipboard
        if (log.shareableData?.isNotEmpty ?? false)
          TextButton(
            onPressed: () => PlatformAdapter.setClipboard(log.content),
            child: Text('console_page.copy'.tr()),
          ),
        // close dialog
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('basis.close'.tr()),
        ),
      ],
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow(this.title, this.value);

  final String title;
  final String? value;

  @override
  Widget build(final BuildContext context) => SelectableText.rich(
        TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value ?? ''),
          ],
        ),
      );
}

class _DataRow extends StatelessWidget {
  const _DataRow(this.data);
  final String? data;

  @override
  Widget build(final BuildContext context) => SelectableText(
        data ?? 'null',
        style: const TextStyle(fontWeight: FontWeight.w400),
      );
}

class _SectionRow extends StatelessWidget {
  const _SectionRow(this.title);
  final String title;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 2.4,
              ),
            ),
          ),
          child: SelectableText(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      );
}
