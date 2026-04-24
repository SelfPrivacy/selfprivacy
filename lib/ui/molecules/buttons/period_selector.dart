import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/ui/atoms/buttons/segmented_buttons.dart';

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({
    required this.period,
    required this.onChange,
    super.key,
  });

  final Period period;
  final Function(Period) onChange;

  @override
  Widget build(final BuildContext context) => SegmentedButtons(
    isSelected: [
      period == Period.month,
      period == Period.day,
      period == Period.hour,
    ],
    onPressed: (final index) {
      switch (index) {
        case 0:
          onChange(Period.month);
        case 1:
          onChange(Period.day);
        case 2:
          onChange(Period.hour);
      }
    },
    titles: [
      'resource_chart.month'.tr(),
      'resource_chart.day'.tr(),
      'resource_chart.hour'.tr(),
    ],
  );
}
