import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class LogListItem extends StatelessWidget {
  const LogListItem({
    required this.message,
    super.key,
  });

  final Message message;

  @override
  Widget build(final BuildContext context) {
    final messageItem = message;
    if (messageItem is RestApiRequestMessage) {
      return _RestApiRequestMessageItem(message: messageItem);
    } else if (messageItem is RestApiResponseMessage) {
      return _RestApiResponseMessageItem(message: messageItem);
    } else if (messageItem is GraphQlResponseMessage) {
      return _GraphQlResponseMessageItem(message: messageItem);
    } else if (messageItem is GraphQlRequestMessage) {
      return _GraphQlRequestMessageItem(message: messageItem);
    } else {
      return _DefaultMessageItem(message: messageItem);
    }
  }
}

class _RestApiRequestMessageItem extends StatelessWidget {
  const _RestApiRequestMessageItem({required this.message});

  final RestApiRequestMessage message;

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(
          '${message.method}\n${message.uri}',
        ),
        subtitle: Text(message.timeString),
        leading: const Icon(Icons.upload_outlined),
        iconColor: Theme.of(context).colorScheme.secondary,
        onTap: () => showDialog(
          context: context,
          builder: (final BuildContext context) => AlertDialog(
            scrollable: true,
            title: Text(
              '${message.method}\n${message.uri}',
            ),
            content: Column(
              children: [
                Text(message.timeString),
                const SizedBox(height: 16),
                // Headers is a map of key-value pairs
                if (message.headers != null) const Text('Headers'),
                if (message.headers != null)
                  Text(
                    message.headers!.entries
                        .map((final entry) => '${entry.key}: ${entry.value}')
                        .join('\n'),
                  ),
                if (message.data != null && message.data != 'null')
                  const Text('Data'),
                if (message.data != null && message.data != 'null')
                  Text(message.data!),
              ],
            ),
            actions: [
              // A button to copy the request to the clipboard
              if (message.text != null)
                TextButton(
                  onPressed: () {
                    PlatformAdapter.setClipboard(message.text ?? '');
                  },
                  child: Text('console_page.copy'.tr()),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('basis.close'.tr()),
              ),
            ],
          ),
        ),
      );
}

class _RestApiResponseMessageItem extends StatelessWidget {
  const _RestApiResponseMessageItem({required this.message});

  final RestApiResponseMessage message;

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(
          '${message.statusCode} ${message.method}\n${message.uri}',
        ),
        subtitle: Text(message.timeString),
        leading: const Icon(Icons.download_outlined),
        iconColor: Theme.of(context).colorScheme.primary,
        onTap: () => showDialog(
          context: context,
          builder: (final BuildContext context) => AlertDialog(
            scrollable: true,
            title: Text(
              '${message.statusCode} ${message.method}\n${message.uri}',
            ),
            content: Column(
              children: [
                Text(message.timeString),
                const SizedBox(height: 16),
                // Headers is a map of key-value pairs
                if (message.data != null && message.data != 'null')
                  const Text('Data'),
                if (message.data != null && message.data != 'null')
                  Text(message.data!),
              ],
            ),
            actions: [
              // A button to copy the request to the clipboard
              if (message.text != null)
                TextButton(
                  onPressed: () {
                    PlatformAdapter.setClipboard(message.text ?? '');
                  },
                  child: Text('console_page.copy'.tr()),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('basis.close'.tr()),
              ),
            ],
          ),
        ),
      );
}

class _GraphQlResponseMessageItem extends StatelessWidget {
  const _GraphQlResponseMessageItem({required this.message});

  final GraphQlResponseMessage message;

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(
          'GraphQL Response at ${message.timeString}',
        ),
        subtitle: Text(
          message.data.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: const Icon(Icons.arrow_circle_down_outlined),
        iconColor: Theme.of(context).colorScheme.tertiary,
        onTap: () => showDialog(
          context: context,
          builder: (final BuildContext context) => AlertDialog(
            scrollable: true,
            title: Text(
              'GraphQL Response at ${message.timeString}',
            ),
            content: Column(
              children: [
                Text(message.timeString),
                const Divider(),
                if (message.data != null) const Text('Data'),
                // Data is a map of key-value pairs
                if (message.data != null)
                  Text(
                    message.data!.entries
                        .map((final entry) => '${entry.key}: ${entry.value}')
                        .join('\n'),
                  ),
                const Divider(),
                if (message.errors != null) const Text('Errors'),
                if (message.errors != null)
                  Text(
                    message.errors!
                        .map(
                          (final entry) =>
                              '${entry.message} at ${entry.locations}',
                        )
                        .join('\n'),
                  ),
                const Divider(),
                if (message.context != null) const Text('Context'),
                if (message.context != null)
                  Text(
                    message.context!.toString(),
                  ),
              ],
            ),
            actions: [
              // A button to copy the request to the clipboard
              if (message.text != null)
                TextButton(
                  onPressed: () {
                    PlatformAdapter.setClipboard(message.text ?? '');
                  },
                  child: Text('console_page.copy'.tr()),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('basis.close'.tr()),
              ),
            ],
          ),
        ),
      );
}

class _GraphQlRequestMessageItem extends StatelessWidget {
  const _GraphQlRequestMessageItem({required this.message});

  final GraphQlRequestMessage message;

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(
          'GraphQL Request at ${message.timeString}',
        ),
        subtitle: Text(
          message.operation.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: const Icon(Icons.arrow_circle_up_outlined),
        iconColor: Theme.of(context).colorScheme.secondary,
        onTap: () => showDialog(
          context: context,
          builder: (final BuildContext context) => AlertDialog(
            scrollable: true,
            title: Text(
              'GraphQL Response at ${message.timeString}',
            ),
            content: Column(
              children: [
                Text(message.timeString),
                const Divider(),
                if (message.operation != null) const Text('Operation'),
                // Data is a map of key-value pairs
                if (message.operation != null)
                  Text(
                    message.operation!.toString(),
                  ),
                const Divider(),
                if (message.variables != null) const Text('Variables'),
                if (message.variables != null)
                  Text(
                    message.variables!.entries
                        .map((final entry) => '${entry.key}: ${entry.value}')
                        .join('\n'),
                  ),
                const Divider(),
                if (message.context != null) const Text('Context'),
                if (message.context != null)
                  Text(
                    message.context!.toString(),
                  ),
              ],
            ),
            actions: [
              // A button to copy the request to the clipboard
              if (message.text != null)
                TextButton(
                  onPressed: () {
                    PlatformAdapter.setClipboard(message.text ?? '');
                  },
                  child: Text('console_page.copy'.tr()),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('basis.close'.tr()),
              ),
            ],
          ),
        ),
      );
}

class _DefaultMessageItem extends StatelessWidget {
  const _DefaultMessageItem({required this.message});

  final Message message;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '${message.timeString}: \n',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: message.text),
            ],
          ),
        ),
      );
}
