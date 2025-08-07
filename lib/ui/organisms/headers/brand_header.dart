import 'package:flutter/material.dart';

class BrandHeader extends StatelessWidget implements PreferredSizeWidget {
  const BrandHeader({
    super.key,
    this.title = '',
    this.hasBackButton = false,
    this.onBackButtonPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(52);

  final String title;
  final bool hasBackButton;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(final BuildContext context) => AppBar(
    centerTitle: true,
    title: Text(title),
    leading:
        hasBackButton
            ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed:
                  onBackButtonPressed ?? () => Navigator.of(context).pop(),
            )
            : null,
  );
}
