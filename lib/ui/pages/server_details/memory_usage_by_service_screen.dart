import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/ui/atoms/buttons/segmented_buttons.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

@RoutePage()
class MemoryUsageByServiceScreen extends StatelessWidget {
  const MemoryUsageByServiceScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MetricsCubit()..restart(),
        child: const _MemoryUsageByServiceContents(),
      );
}

class _MemoryUsageByServiceContents extends StatelessWidget {
  const _MemoryUsageByServiceContents();

  @override
  Widget build(final BuildContext context) {
    final MetricsCubit cubit = context.watch<MetricsCubit>();
    final Period period = cubit.state.period;
    final MetricsState state = cubit.state;

    final List<Widget> children = [];

    if (state is MetricsUnsupported ||
        (state is MetricsLoaded && state.memoryMetrics == null)) {
      children.addAll([
        Center(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: EmptyPagePlaceholder(
                title: 'basis.error'.tr(),
                description:
                    'resource_chart.failed_to_load_memory_metrics'.tr(),
                iconData: Icons.error_outline_outlined,
              ),
            ),
          ),
        ),
      ]);
    }
    if (state is MetricsLoading) {
      children.addAll([
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ]);
    }

    if (state is MetricsLoaded && state.memoryMetrics != null) {
      final averageUsageByServices =
          state.memoryMetrics!.averageMetricsByService;
      final maxUsageByServices = state.memoryMetrics!.maxMetricsByService;

      // For each service, gather average and max usages
      for (final slice in averageUsageByServices.keys.sorted()) {
        final DiskSize averageUsage =
            DiskSize(byte: averageUsageByServices[slice]?.toInt() ?? 0);
        final DiskSize maxUsage =
            DiskSize(byte: maxUsageByServices[slice]?.toInt() ?? 0);
        String? serviceName;
        Widget? icon;
        if (slice == 'system') {
          serviceName = 'resource_chart.system'.tr();
          icon = const Icon(BrandIcons.server);
        } else if (slice == 'user') {
          serviceName = 'resource_chart.ssh_users'.tr();
          icon = const Icon(BrandIcons.terminal);
        } else {
          final service = context
              .read<ServicesBloc>()
              .state
              .getServiceById(slice.replaceAll('_', '-'));
          serviceName = service?.displayName ?? slice;
          icon = service?.svgIcon != null
              ? SvgPicture.string(
                  service!.svgIcon,
                  width: 22.0,
                  height: 24.0,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                )
              : const Icon(BrandIcons.box);
        }

        if (serviceName == slice &&
            averageUsage.byte == 0 &&
            maxUsage.byte == 0) {
          continue;
        }

        children.add(
          ListTile(
            title: Text(serviceName),
            subtitle: Text(
              'resource_chart.ram_usage'.tr(
                namedArgs: {
                  'average': averageUsage.toString(),
                  'max': maxUsage.toString(),
                },
              ),
            ),
            dense: true,
            leading: icon,
          ),
        );
      }
    }

    return BrandHeroScreen(
      heroTitle: 'resource_chart.memory'.tr(),
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
            'resource_chart.hour'.tr(),
          ],
        ),
        ...children,
      ],
    );
  }
}
