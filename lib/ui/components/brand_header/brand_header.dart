import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/pre_styled_buttons/pre_styled_buttons.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    Key? key,
    required this.title,
    this.hasBackButton = false,
    this.hasFlashButton = false,
  }) : super(key: key);

  final String title;
  final bool hasBackButton;
  final bool hasFlashButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: hasBackButton ? 1 : 15,
      ),
      child: Container(
        child: Row(
          children: [
            if (hasBackButton) ...[
              IconButton(
                icon: Icon(BrandIcons.arrow_left),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10),
            ],
            BrandText.h4(title),
            Spacer(),
            if (hasFlashButton) PreStyledButtons.flash(),
          ],
        ),
      ),
    );
  }
}
