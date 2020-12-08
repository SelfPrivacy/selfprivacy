import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    Key key,
    @required this.title,
    this.hasBackButton = false,
  }) : super(key: key);

  final String title;
  final bool hasBackButton;

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
          ],
        ),
      ),
    );
  }
}
