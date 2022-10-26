import 'package:flutter/material.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    super.key,
    this.title = '',
    this.hasBackButton = false,
    this.onBackButtonPressed,
  });

  final String title;
  final bool hasBackButton;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(final BuildContext context) => AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(title),
        ),
        leading: hasBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed:
                    onBackButtonPressed ?? () => Navigator.of(context).pop(),
              )
            : null,
      );
}
