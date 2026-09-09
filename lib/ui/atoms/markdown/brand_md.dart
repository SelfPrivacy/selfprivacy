import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandMarkdown extends StatefulWidget {
  const BrandMarkdown({required this.fileName, super.key});

  final String fileName;

  @override
  State<BrandMarkdown> createState() => _BrandMarkdownState();
}

class _BrandMarkdownState extends State<BrandMarkdown> {
  String _mdContent = '';

  String? _loadedPath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadIfChanged();
  }

  @override
  void didUpdateWidget(final BrandMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadIfChanged();
  }

  void _loadIfChanged() {
    final locale = context.locale;
    final path = 'assets/markdown/${widget.fileName}-${locale.languageCode}.md';
    if (path == _loadedPath) {
      return;
    }
    _loadedPath = path;
    unawaited(_loadMdFile(path));
  }

  Future<void> _loadMdFile(final String path) async {
    String content;
    try {
      content = await rootBundle.loadString(path);
    } on FlutterError {
      content = await rootBundle.loadString(
        'assets/markdown/${widget.fileName}-en.md',
      );
    }
    if (mounted && path == _loadedPath) {
      setState(() => _mdContent = content);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final MarkdownStyleSheet markdown = MarkdownStyleSheet();
    return MarkdownBody(
      shrinkWrap: true,
      styleSheet: markdown,
      selectable: true,
      onTapLink:
          (final String text, final String? href, final String title) async {
            if (href == null) {
              return;
            }

            final Uri? uri = Uri.tryParse(href);

            if (uri == null) {
              return;
            }

            await launchUrl(uri, mode: _launchModeForCurrentPlatform());
          },
      data: _mdContent,
    );
  }

  LaunchMode _launchModeForCurrentPlatform() {
    if (kIsWeb) {
      return LaunchMode.platformDefault;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.fuchsia => LaunchMode.platformDefault,
      TargetPlatform.linux ||
      TargetPlatform.macOS ||
      TargetPlatform.windows => LaunchMode.externalApplication,
    };
  }
}
