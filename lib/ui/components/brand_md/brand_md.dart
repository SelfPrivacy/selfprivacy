import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BrandMarkdown extends StatefulWidget {
  const BrandMarkdown({
    required this.fileName,
    final super.key,
  });

  final String fileName;

  @override
  State<BrandMarkdown> createState() => _BrandMarkdownState();
}

class _BrandMarkdownState extends State<BrandMarkdown> {
  String _mdContent = '';

  @override
  void initState() {
    super.initState();
    _loadMdFile();
  }

  void _loadMdFile() async {
    final String mdFromFile = await rootBundle
        .loadString('assets/markdown/${widget.fileName}-${'locale'.tr()}.md');
    setState(() {
      _mdContent = mdFromFile;
    });
  }

  @override
  Widget build(final BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final MarkdownStyleSheet markdown = MarkdownStyleSheet(
      p: defaultTextStyle.copyWith(
        color: isDark ? BrandColors.white : null,
      ),
      h1: headline1Style.copyWith(
        color: isDark ? BrandColors.white : null,
      ),
      h2: headline2Style.copyWith(
        color: isDark ? BrandColors.white : null,
      ),
      h3: headline3Style.copyWith(
        color: isDark ? BrandColors.white : null,
      ),
      h4: headline4Style.copyWith(
        color: isDark ? BrandColors.white : null,
      ),
    );
    return MarkdownBody(
      shrinkWrap: true,
      styleSheet: markdown,
      onTapLink: (final String text, final String? href, final String title) {
        if (href != null) {
          canLaunchUrlString(href).then((final bool canLaunchURL) {
            if (canLaunchURL) {
              launchUrlString(href);
            }
          });
        }
      },
      data: _mdContent,
    );
  }
}
