import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';

class KeyDisplay extends StatelessWidget {
  const KeyDisplay({
    required this.keyToDisplay,
    required this.canCopy,
    required this.infoboxText,
    super.key,
  });

  final String keyToDisplay;
  final bool canCopy;
  final String infoboxText;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(),
      const SizedBox(height: 16),
      if (canCopy)
        SelectableText(
          keyToDisplay,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 24,
            fontFamily: 'RobotoMono',
          ),
          textAlign: TextAlign.center,
        ),
      if (!canCopy)
        Text(
          keyToDisplay,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 24,
            fontFamily: 'RobotoMono',
          ),
          textAlign: TextAlign.center,
        ),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      InfoBox(text: infoboxText),
      const SizedBox(height: 16),
      BrandButton.filled(
        child: Text('basis.done'.tr()),
        onPressed: () {
          Navigator.of(context).popUntil((final route) => route.isFirst);
        },
      ),
      const SizedBox(height: 24),
    ],
  );
}
