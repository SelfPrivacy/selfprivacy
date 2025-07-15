import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

extension on ConsoleLog {
  List<Widget> unwrapContent(final BuildContext context) => switch (this) {
    (final RestApiRequestConsoleLog log) => [
      if (log.method != null) _KeyValueRow('method', log.method),
      if (log.uri != null) _KeyValueRow('uri', '${log.uri}'),

      // headers bloc
      if (log.headers?.isNotEmpty ?? false) ...[
        const _SectionRow('console_page.headers'),
        for (final entry in log.headers!.entries)
          _KeyValueRow(entry.key, '${entry.value}'),
      ],

      // data
      const _SectionRow('console_page.data'),
      _DataRow('${log.data}'),
    ],
    (final RestApiResponseConsoleLog log) => [
      if (log.method != null) _KeyValueRow('method', '${log.method}'),
      if (log.uri != null) _KeyValueRow('uri', '${log.uri}'),
      if (log.statusCode != null)
        _KeyValueRow('statusCode', '${log.statusCode}'),

      // data
      const _SectionRow('console_page.response_data'),
      _DataRow('${log.data}'),
    ],
    (final GraphQlRequestConsoleLog log) => [
      // // context
      // if (log.context != null) ...[
      //   const _SectionRow('console_page.context'),
      //   _DataRow('${log.context}'),
      // ],
      const _SectionRow('console_page.operation'),
      if (log.operation != null) ...[
        _KeyValueRow('console_page.operation_type'.tr(), log.operationType),
        _KeyValueRow(
          'console_page.operation_name'.tr(),
          log.operation?.operationName,
        ),
        const Divider(),
        // data
        _DataRow(log.operationDocument),
      ],
      // preset variables
      if (log.variables?.isNotEmpty ?? false) ...[
        const _SectionRow('console_page.variables'),
        for (final entry in log.variables!.entries)
          _KeyValueRow(entry.key, '${entry.value}'),
      ],
    ],
    (final GraphQlResponseConsoleLog log) => [
      // // context
      // const _SectionRow('console_page.context'),
      // _DataRow('${log.context}'),
      // data
      if (log.data != null) ...[
        const _SectionRow('console_page.data'),
        for (final entry in log.data!.entries)
          _KeyValueRow(entry.key, '${entry.value}'),
      ],
      // errors
      if (log.errors?.isNotEmpty ?? false) ...[
        const _SectionRow('console_page.errors'),
        for (final entry in log.errors!) ...[
          _KeyValueRow('${'console_page.error_message'.tr()}: ', entry.message),
          _KeyValueRow('${'console_page.error_path'.tr()}: ', '${entry.path}'),
          if (entry.locations?.isNotEmpty ?? false)
            _KeyValueRow(
              '${'console_page.error_locations'.tr()}: ',
              '${entry.locations}',
            ),
          if (entry.extensions?.isNotEmpty ?? false)
            _KeyValueRow(
              '${'console_page.error_extensions'.tr()}: ',
              '${entry.extensions}',
            ),
          const Divider(),
        ],
      ],
    ],
    (final ManualConsoleLog log) => [_DataRow(log.content)],
  };
}

/// dialog with detailed log content
class ConsoleItemDialog extends StatelessWidget {
  const ConsoleItemDialog({required this.log, super.key});

  final ConsoleLog log;

  @override
  Widget build(final BuildContext context) => AlertDialog(
    scrollable: true,
    title: Text(log.title),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SelectableText.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: '${'console_page.logged_at'.tr()}: ',
                  style: const TextStyle(),
                ),
                TextSpan(
                  text: '${log.timeString} (${log.fullUTCString})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        ...log.unwrapContent(context),
      ],
    ),
    actions: [
      if (log is LogWithRawResponse)
        TextButton(
          onPressed:
              () => PlatformAdapter.setClipboard(
                (log as LogWithRawResponse).rawResponse,
              ),
          child: Text('console_page.copy_raw'.tr()),
        ),
      // A button to copy the request to the clipboard
      if (log.shareableData?.isNotEmpty ?? false)
        TextButton(
          onPressed: () => PlatformAdapter.setClipboard(log.shareableData!),
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

/// different sections delimiter with `title`
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
        title.tr(),
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
      ),
    ),
  );
}

/// data row with a {key: value} pair
class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow(this.title, this.value);

  /// headers thath should be hidden in screenshots, but still accessible for
  /// user, as opposed to `[[ConsoleLog]]`
  /// `RestApiRequestConsoleLog.blacklistedHeaders` which need to be filtered
  /// out from clipboard content
  static const List<String> hideList = ['Authorization'];

  final String title;
  final String? value;

  @override
  Widget build(final BuildContext context) =>
      hideList.contains(title)
          ? _ObscuredKeyValueRow(title, value)
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SelectableText.rich(
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
            ),
          );
}

class _ObscuredKeyValueRow extends StatefulWidget {
  const _ObscuredKeyValueRow(this.title, this.value);

  final String title;
  final String? value;

  @override
  State<_ObscuredKeyValueRow> createState() => _ObscuredKeyValueRowState();
}

class _ObscuredKeyValueRowState extends State<_ObscuredKeyValueRow> {
  static const obscuringCharacter = '•';
  bool _obscureValue = true;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        Expanded(
          child: SelectableText.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: '${widget.title}: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      _obscureValue
                          ? obscuringCharacter * (widget.value?.length ?? 4)
                          : widget.value ?? '',
                  style: const TextStyle(
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            _obscureValue
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            _obscureValue ^= true; // toggle value
            setState(() {});
          },
        ),
      ],
    ),
  );
}

/// data row with only text
class _DataRow extends StatelessWidget {
  const _DataRow(this.data);

  final String? data;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: SelectableText(
      data ?? 'null',
      style: const TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}
