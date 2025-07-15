import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BrandMarkdown extends StatefulWidget {
  const BrandMarkdown({required this.fileName, super.key});

  final String fileName;

  @override
  State<BrandMarkdown> createState() => _BrandMarkdownState();
}

class _BrandMarkdownState extends State<BrandMarkdown> {
  String _mdContent = '';

  @override
  void initState() {
    super.initState();
    unawaited(_loadMdFile());
  }

  Future<void> _loadMdFile() async {
    final String mdFromFile = await rootBundle.loadString(
      'assets/markdown/${widget.fileName}-${'locale'.tr()}.md',
    );
    setState(() {
      _mdContent = mdFromFile;
    });
  }

  @override
  Widget build(final BuildContext context) {
    final MarkdownStyleSheet markdown = MarkdownStyleSheet();
    return MarkdownBody(
      shrinkWrap: true,
      styleSheet: markdown,
      selectable: true,
      onTapLink: (
        final String text,
        final String? href,
        final String title,
      ) async {
        if (href != null) {
          await canLaunchUrlString(href).then((final bool canLaunchURL) async {
            if (canLaunchURL) {
              await launchUrlString(href);
            }
          });
        }
      },
      data: _mdContent,
    );
  }
}
