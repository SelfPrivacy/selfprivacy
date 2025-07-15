import 'package:flutter/material.dart';

class ListTileOnSurfaceVariant extends StatelessWidget {
  const ListTileOnSurfaceVariant({
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.onTap,
    this.disableSubtitleOverflow = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Function()? onTap;
  final bool disableSubtitleOverflow;

  Widget? getSubtitle() {
    if (subtitle == null) {
      return null;
    }
    if (disableSubtitleOverflow) {
      return Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis);
    }
    return Text(subtitle!);
  }

  @override
  Widget build(final BuildContext context) => ListTile(
    title: Text(title),
    subtitle: getSubtitle(),
    onTap: onTap,
    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
    leading: leadingIcon != null ? Icon(leadingIcon) : null,
    iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
  );
}
