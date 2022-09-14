import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_radio/brand_radio.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

// TODO: Delete this file

class BrandRadioTile extends StatelessWidget {
  const BrandRadioTile({
    required this.isChecked,
    required this.text,
    required this.onPress,
    final super.key,
  });

  final bool isChecked;

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(final BuildContext context) => GestureDetector(
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
