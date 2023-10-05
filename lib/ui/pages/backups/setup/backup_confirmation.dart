import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';

class BackupConfirmationPage extends StatelessWidget {
  const BackupConfirmationPage({
    required this.onConfirmCallback,
    super.key,
  });

  final Function() onConfirmCallback;

  @override
  Widget build(final BuildContext context) => ResponsiveLayoutWithInfobox(
        topChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm and connect TEST',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        primaryColumn: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            BrandButton.rised(
              onPressed: () {
                onConfirmCallback();
              },
              text: 'basis.connect'.tr(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
}
