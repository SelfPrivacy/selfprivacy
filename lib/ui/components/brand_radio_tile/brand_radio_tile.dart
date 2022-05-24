import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_radio/brand_radio.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class BrandRadioTile extends StatelessWidget {
  const BrandRadioTile({
    Key? key,
    required this.isChecked,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final bool isChecked;

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            BrandRadio(
              isChecked: isChecked,
            ),
            const SizedBox(width: 9),
            BrandText.h5(text)
          ],
        ),
      ),
    );
  }
}
