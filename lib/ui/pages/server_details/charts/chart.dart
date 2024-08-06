part of '../server_details_screen.dart';

class _Chart extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final MetricsCubit cubit = context.watch<MetricsCubit>();
    final Period period = cubit.state.period;
    final MetricsState state = cubit.state;
    List<Widget> charts;

    List<Color> getGraphColors(final BuildContext context, final int length) {
      final colors = [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.tertiary,
        Theme.of(context).colorScheme.secondary,
        ...harmonizedBasicColors(context),
      ];
      if (length <= colors.length) {
        return colors.sublist(0, length);
      } else {
        return List.generate(
          length,
          (final index) => colors[index % colors.length],
        );
      }
    }

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
        if (!(state is MetricsLoaded && state.memoryMetrics == null))
          FilledCard(
            clipped: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'resource_chart.memory'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      if (state is MetricsLoaded && state.memoryMetrics != null)
                        getMemoryChart(state),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: state is MetricsLoading ? 1 : 0,
                        child: const _GraphLoadingCardContent(),
                      ),
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('resource_chart.view_usage_by_service'.tr()),
                    leading: Icon(
                      Icons.area_chart_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    onTap: () {
                      context.pushRoute(
                        const MemoryUsageByServiceRoute(),
                      );
                    },
                    enabled: state is MetricsLoaded,
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'resource_chart.network_title'.tr(),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.end,
                        runAlignment: WrapAlignment.end,
                        children: [
                          Legend(
                            color: Theme.of(context).colorScheme.primary,
                            text: 'resource_chart.in'.tr(),
                          ),
                          Legend(
                            color: Theme.of(context).colorScheme.tertiary,
                            text: 'resource_chart.out'.tr(),
                          ),
                        ],
                      ),
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
        const SizedBox(height: 8),
        if (!(state is MetricsLoaded && state.diskMetrics == null))
          Builder(
            builder: (final context) {
              List<DiskGraphData> getDisksGraphData(
                final BuildContext context,
              ) {
                if (state is! MetricsLoaded) {
                  return [];
                }
                final diskData = state.diskMetrics?.diskMetrics;
                if (diskData == null) {
                  return [];
                }
                final List<DiskGraphData> res = [];
                final colors = getGraphColors(context, diskData.keys.length);
                for (final entry in diskData.entries) {
                  res.add(
                    DiskGraphData(
                      volume: context
                          .read<VolumesBloc>()
                          .state
                          .getVolume(entry.key.split('/').last),
                      color: colors[diskData.keys.toList().indexOf(entry.key)],
                      diskData: entry.value,
                      originalId: entry.key,
                    ),
                  );
                }

                return res;
              }

              final disksGraphData = getDisksGraphData(context);

              return FilledCard(
                clipped: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'resource_chart.disk_title'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              alignment: WrapAlignment.end,
                              runAlignment: WrapAlignment.end,
                              children: disksGraphData
                                  .map<Widget>(
                                    (final disk) => Legend(
                                      color: disk.color,
                                      text: disk.volume.displayName,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          if (state is MetricsLoaded &&
                              state.diskMetrics != null)
                            getDiskChart(state, disksGraphData),
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
              );
            },
          ),
      ];
    } else if (state is MetricsUnsupported) {
      charts = [
        FilledCard(
          clipped: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'resource_chart.unsupported'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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
        if (state is! MetricsUnsupported)
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
              'resource_chart.hour'.tr(),
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

  Widget getMemoryChart(final MetricsLoaded state) {
    final data = state.memoryMetrics;

    if (data == null) {
      return const SizedBox();
    }

    return SizedBox(
      height: 200,
      child: MemoryChart(
        data: data.overallMetrics,
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

Widget getDiskChart(
  final MetricsLoaded state,
  final List<DiskGraphData> diskData,
) {
  final data = state.diskMetrics;

  if (data == null) {
    return const SizedBox();
  }

  return SizedBox(
    height: 200,
    child: DiskChart(
      diskData: diskData,
      period: state.period,
      start: state.metrics.start,
    ),
  );
}

class _GraphLoadingCardContent extends StatelessWidget {
  const _GraphLoadingCardContent();

  @override
  Widget build(final BuildContext context) => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator.adaptive()),
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
        mainAxisSize: MainAxisSize.min,
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

class DiskGraphData {
  DiskGraphData({
    required this.volume,
    required this.color,
    required this.diskData,
    required this.originalId,
  });

  final DiskVolume volume;
  final Color color;
  final List<TimeSeriesData> diskData;
  final String originalId;
}
