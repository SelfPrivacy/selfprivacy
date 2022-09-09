import 'package:flutter/material.dart';

class BrandDivider extends StatelessWidget {
  const BrandDivider({final super.key});

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: 1,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(30),
      );
}
