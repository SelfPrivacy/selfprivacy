import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BrandMarkdown extends StatefulWidget {
  const BrandMarkdown({
    Key? key,
    required this.fileName,
  }) : super(key: key);

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
    String mdFromFile = await rootBundle
        .loadString('assets/markdown/${widget.fileName}-${'locale'.tr()}.md');
    setState(() {
      _mdContent = mdFromFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var markdown = MarkdownStyleSheet(
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
    return Markdown(
      shrinkWrap: true,
      styleSheet: markdown,
      onTapLink: (String text, String? href, String title) {
        if (href != null) {
          canLaunchUrlString(href).then((canLaunchURL) {
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
