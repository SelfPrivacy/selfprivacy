import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    final super.key,
    this.title = '',
    this.hasBackButton = false,
    this.onBackButtonPressed,
  });

  final String title;
  final bool hasBackButton;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(final BuildContext context) => Container(
        height: 52,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: hasBackButton ? 1 : 15,
        ),
        child: Row(
          children: [
            if (hasBackButton) ...[
              IconButton(
                icon: const Icon(BrandIcons.arrowLeft),
                onPressed:
                    onBackButtonPressed ?? () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 10),
            ],
            BrandText.h4(title),
            const Spacer(),
          ],
        ),
      );
}
