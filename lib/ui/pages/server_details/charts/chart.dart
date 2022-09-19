part of '../server_details_screen.dart';

class _Chart extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final HetznerMetricsCubit cubit = context.watch<HetznerMetricsCubit>();
    final Period period = cubit.state.period;
    final HetznerMetricsState state = cubit.state;
    List<Widget> charts;
    if (state is HetznerMetricsLoaded || state is HetznerMetricsLoading) {
      charts = [
        FilledCard(
          clipped: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'providers.server.chart.cpu_title'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state is HetznerMetricsLoaded) getCpuChart(state),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: state is HetznerMetricsLoading ? 1 : 0,
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
                      'providers.server.chart.network_title'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const Spacer(),
                    Legend(
                      color: Theme.of(context).colorScheme.primary,
                      text: 'providers.server.chart.in'.tr(),
                    ),
                    const SizedBox(width: 5),
                    Legend(
                      color: Theme.of(context).colorScheme.tertiary,
                      text: 'providers.server.chart.out'.tr(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state is HetznerMetricsLoaded) getBandwidthChart(state),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: state is HetznerMetricsLoading ? 1 : 0,
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
            'providers.server.chart.month'.tr(),
            'providers.server.chart.day'.tr(),
            'providers.server.chart.hour'.tr()
          ],
        ),
        const SizedBox(height: 8),
        ...charts,
      ],
    );
  }

  Widget getCpuChart(final HetznerMetricsLoaded state) {
    final data = state.cpu;

    return SizedBox(
      height: 200,
      child: CpuChart(
        data: data,
        period: state.period,
        start: state.start,
      ),
    );
  }

  Widget getBandwidthChart(final HetznerMetricsLoaded state) {
    final ppsIn = state.bandwidthIn;
    final ppsOut = state.bandwidthOut;

    return SizedBox(
      height: 200,
      child: NetworkChart(
        listData: [ppsIn, ppsOut],
        period: state.period,
        start: state.start,
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
    final super.key,
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
