import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@Deprecated('Use skeletons instead')
class BrandLoader {
  static HorizontalLoader horizontal() => const HorizontalLoader();
}

class HorizontalLoader extends StatelessWidget {
  const HorizontalLoader({super.key});

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
