import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrModal extends StatelessWidget {
  const QrModal({
    required this.title,
    required this.qrData,
    required this.scrollController,
    super.key,
  });

  final String title;
  final String qrData;
  final ScrollController scrollController;

  @override
  Widget build(final BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    controller: scrollController,
    children: [
      const Gap(16),
      Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      const Gap(16),
      QrImageView(
        data: qrData,
        version: QrVersions.auto,
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        eyeStyle: QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ],
  );
}
