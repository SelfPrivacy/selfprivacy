part of '../server_details_screen.dart';

class _Chart extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final MetricsCubit cubit = context.watch<MetricsCubit>();
    final Period period = cubit.state.period;
    final MetricsState state = cubit.state;
    List<Widget> charts;
    if (state is MetricsLoaded || state is MetricsLoading) {
      charts = [
        FilledCard(
          clipped: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'resource_chart.cpu_title'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state is MetricsLoaded) getCpuChart(state),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: state is MetricsLoading ? 1 : 0,
                      child: const _GraphLoadingCardContent(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        FilledCard(
          clipped: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'resource_chart.network_title'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const Spacer(),
                    Legend(
                      color: Theme.of(context).colorScheme.primary,
                      text: 'resource_chart.in'.tr(),
                    ),
                    const SizedBox(width: 5),
                    Legend(
                      color: Theme.of(context).colorScheme.tertiary,
                      text: 'resource_chart.out'.tr(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state is MetricsLoaded) getBandwidthChart(state),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: state is MetricsLoading ? 1 : 0,
                      child: const _GraphLoadingCardContent(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ];
    } else {
      throw 'wrong state';
    }

    return Column(
      children: [
        SegmentedButtons(
          isSelected: [
            period == Period.month,
            period == Period.day,
            period == Period.hour,
          ],
          onPressed: (final index) {
            switch (index) {
              case 0:
                cubit.changePeriod(Period.month);
                break;
              case 1:
                cubit.changePeriod(Period.day);
                break;
              case 2:
                cubit.changePeriod(Period.hour);
                break;
            }
          },
          titles: [
            'resource_chart.month'.tr(),
            'resource_chart.day'.tr(),
            'resource_chart.hour'.tr()
          ],
        ),
        const SizedBox(height: 8),
        ...charts,
      ],
    );
  }

  Widget getCpuChart(final MetricsLoaded state) {
    final data = state.metrics.cpu;

    return SizedBox(
      height: 200,
      child: CpuChart(
        data: data,
        period: state.period,
        start: state.metrics.start,
      ),
    );
  }

  Widget getBandwidthChart(final MetricsLoaded state) {
    final ppsIn = state.metrics.bandwidthIn;
    final ppsOut = state.metrics.bandwidthOut;

    return SizedBox(
      height: 200,
      child: NetworkChart(
        listData: [ppsIn, ppsOut],
        period: state.period,
        start: state.metrics.start,
      ),
    );
  }
}

class _GraphLoadingCardContent extends StatelessWidget {
  const _GraphLoadingCardContent();

  @override
  Widget build(final BuildContext context) => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
}

class Legend extends StatelessWidget {
  const Legend({
    required this.color,
    required this.text,
    super.key,
  });

  final String text;
  final Color color;
  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ColoredBox(color: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      );
}

class _ColoredBox extends StatelessWidget {
  const _ColoredBox({
    required this.color,
  });

  final Color color;

  @override
  Widget build(final BuildContext context) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color.withOpacity(0.4),
          border: Border.all(
            color: color,
            width: 1.5,
          ),
        ),
      );
}
