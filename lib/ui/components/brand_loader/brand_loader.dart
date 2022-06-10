import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BrandLoader {
  static HorizontalLoader horizontal() => const HorizontalLoader();
}

class HorizontalLoader extends StatelessWidget {
  const HorizontalLoader({final super.key});

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('basis.wait'.tr()),
          const SizedBox(height: 10),
          const LinearProgressIndicator(minHeight: 3),
        ],
      );
}
