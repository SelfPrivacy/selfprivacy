import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/theming/harmonized_basic_colors.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/chart_elements/legend.dart';
import 'package:selfprivacy/ui/molecules/buttons/period_selector.dart';
import 'package:selfprivacy/ui/molecules/cards/chart_card.dart';
import 'package:selfprivacy/ui/molecules/charts/cpu_chart.dart';
import 'package:selfprivacy/ui/molecules/charts/disk_charts.dart';
import 'package:selfprivacy/ui/molecules/charts/memory_chart.dart';
import 'package:selfprivacy/ui/molecules/charts/network_charts.dart';
import 'package:selfprivacy/ui/router/router.dart';

class ServerCharts extends StatelessWidget {
  const ServerCharts({super.key});

  @override
  Widget build(final BuildContext context) {
    final MetricsCubit cubit = context.watch<MetricsCubit>();
    final Period period = cubit.state.period;
    final MetricsState state = cubit.state;
    List<Widget> charts;

    final metricsLoaded = state is MetricsLoaded;

    if (state is MetricsLoaded || state is MetricsLoading) {
      charts = [
        ChartCard(
          title: 'resource_chart.cpu_title'.tr(),
          chart: metricsLoaded ? getCpuChart(state) : null,
          isLoading: !metricsLoaded,
        ),
        const SizedBox(height: 8),
        if (!(metricsLoaded && state.memoryMetrics == null))
          ChartCard(
            title: 'resource_chart.memory'.tr(),
            chart: metricsLoaded ? getMemoryChart(state) : null,
            isLoading: !metricsLoaded,
            trailing: [
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
                enabled: metricsLoaded,
              ),
            ],
          ),
        const SizedBox(height: 8),
        ChartCard(
          title: 'resource_chart.network_title'.tr(),
          chart: metricsLoaded ? getBandwidthChart(state) : null,
          isLoading: !metricsLoaded,
          legendItems: [
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
        const SizedBox(height: 8),
        if (!(metricsLoaded && state.diskMetrics == null))
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

              return ChartCard(
                title: 'resource_chart.disk_title'.tr(),
                chart: (metricsLoaded && state.diskMetrics != null)
                    ? getDiskChart(state, disksGraphData)
                    : null,
                isLoading: !metricsLoaded,
                legendItems: disksGraphData
                    .map<Widget>(
                      (final disk) => Legend(
                        color: disk.color,
                        text: disk.volume.displayName,
                      ),
                    )
                    .toList(),
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
          PeriodSelector(
            period: period,
            onChange: cubit.changePeriod,
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
        data: [data],
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
        data: [data.overallMetrics],
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
        data: [ppsIn, ppsOut],
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
