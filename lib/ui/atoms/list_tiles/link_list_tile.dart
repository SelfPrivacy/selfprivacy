import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkListTile extends StatelessWidget {
  const LinkListTile({
    required this.title,
    required this.subtitle,
    required this.uri,
    required this.icon,
    this.longPressText,
    super.key,
  });

  final String title;
  final String subtitle;
  final String uri;
  final IconData icon;
  final String? longPressText;

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () => launchUrl(
          Uri.parse(uri),
          mode: LaunchMode.externalApplication,
        ),
        leading: Icon(icon),
        onLongPress: () {
          PlatformAdapter.setClipboard(
            longPressText ?? uri,
          );
          getIt<NavigationService>().showSnackBar(
            'basis.copied_to_clipboard'.tr(),
          );
        },
      );
}