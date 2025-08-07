import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({
    required this.title,
    required this.chart,
    required this.isLoading,
    this.trailing = const [],
    this.legendItems = const [],
    super.key,
  });

  final String title;
  final Widget? chart;
  final bool isLoading;
  final List<Widget> trailing;
  final List<Widget> legendItems;

  @override
  Widget build(final BuildContext context) => FilledCard(
    clipped: false,
    mergeSemantics: trailing.isEmpty,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.end,
                    runAlignment: WrapAlignment.end,
                    children: legendItems,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Stack(
            alignment: Alignment.center,
            children: [
              chart ?? const SizedBox.shrink(),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLoading ? 1 : 0,
                child: const _GraphLoadingCardContent(),
              ),
            ],
          ),
          if (trailing.isNotEmpty) const Divider(),
          ...trailing,
        ],
      ),
    ),
  );
}

class _GraphLoadingCardContent extends StatelessWidget {
  const _GraphLoadingCardContent();

  @override
  Widget build(final BuildContext context) => SizedBox(
    height: 200,
    child: Semantics(
      label: 'resource_chart.loading'.tr(),
      child: const Center(child: CircularProgressIndicator.adaptive()),
    ),
  );
}
