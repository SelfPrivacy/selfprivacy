import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/buttons/period_selector.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'month', type: PeriodSelector, path: '[Molecules]/buttons')
Widget periodSelectorMonth(final BuildContext context) {
  Period period = Period.month;
  return CatalogCase(
    key: const ValueKey('PeriodSelector/month'),
    id: 'PeriodSelector/month',
    variant: 'month',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        PeriodSelector(
          period: period,
          onChange: (final next) => update(() => period = next),
        ),
  );
}

@UseCase(name: 'day', type: PeriodSelector, path: '[Molecules]/buttons')
Widget periodSelectorDay(final BuildContext context) {
  Period period = Period.day;
  return CatalogCase(
    key: const ValueKey('PeriodSelector/day'),
    id: 'PeriodSelector/day',
    variant: 'day',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        PeriodSelector(
          period: period,
          onChange: (final next) => update(() => period = next),
        ),
  );
}

@UseCase(name: 'hour', type: PeriodSelector, path: '[Molecules]/buttons')
Widget periodSelectorHour(final BuildContext context) {
  Period period = Period.hour;
  return CatalogCase(
    key: const ValueKey('PeriodSelector/hour'),
    id: 'PeriodSelector/hour',
    variant: 'hour',
    host: PreviewHost.content,
    width: 560,
    height: 140,
    builder: (final context, final fixtures, final controller, final update) =>
        PeriodSelector(
          period: period,
          onChange: (final next) => update(() => period = next),
        ),
  );
}
