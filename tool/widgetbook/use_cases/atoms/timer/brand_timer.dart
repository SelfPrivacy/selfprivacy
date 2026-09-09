import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/timer/brand_timer.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Running', type: BrandTimer, path: '[Atoms]/timer')
Widget brandTimerRunning(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandTimer/Running'),
  id: 'BrandTimer/Running',
  variant: 'Running',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandTimer(
        startDateTime: referenceTime.subtract(const Duration(seconds: 20)),
        duration: const Duration(seconds: 60),
        now: fixedNow,
      ),
);

@UseCase(name: 'Expired', type: BrandTimer, path: '[Atoms]/timer')
Widget brandTimerExpired(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandTimer/Expired'),
  id: 'BrandTimer/Expired',
  variant: 'Expired',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandTimer(
        startDateTime: referenceTime.subtract(const Duration(seconds: 60)),
        duration: const Duration(seconds: 60),
        now: fixedNow,
      ),
);
