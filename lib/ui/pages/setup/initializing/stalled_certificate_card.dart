import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';

class StalledCertificateCard extends StatelessWidget {
  const StalledCertificateCard({super.key});

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledCard(
      error: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.gpp_maybe_outlined,
                  color: Theme.of(context).colorScheme.error,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'initializing.certificate_stalled_title'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text('initializing.certificate_stalled_description'.tr()),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (final _) => const AboutApplicationPage(),
                  ),
                ),
                child: Text('initializing.certificate_stalled_support'.tr()),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
