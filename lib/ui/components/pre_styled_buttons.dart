import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:easy_localization/easy_localization.dart';

class PreStyledButtons {
  static Widget close({
    required VoidCallback onPress,
  }) =>
      _CloseButton(onPress: onPress);
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandText.h4('basis.close'.tr()),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
