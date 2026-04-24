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
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/buttons/period_selector.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class MemoryUsageByServicePage extends StatelessWidget {
  const MemoryUsageByServicePage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: EmptyPagePlaceholder(
              title: 'basis.error'.tr(),
              description: 'resource_chart.failed_to_load_memory_metrics'.tr(),
              iconData: Icons.error_outline_outlined,
            ),
          ),
        ),
      ]);
    }
    if (state is MetricsLoading) {
      final servicesCount = context.read<ServicesBloc>().state.services.length;
      if (servicesCount < 1) {
        children.addAll([
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: CircularProgressIndicator(),
            ),
          ),
        ]);
      } else {
        children.addAll(
          List.generate(
            // We assume that every service has a slice, and there are also
            // user and system slices
            servicesCount + 2,
            (final index) => const Skeletonizer(
              enabled: true,
              enableSwitchAnimation: true,
              child: ServiceMemoryConsumptionTile.fake(),
            ),
          ),
        );
      }
    }

    if (state is MetricsLoaded && state.memoryMetrics != null) {
      final averageUsageByServices =
          state.memoryMetrics!.averageMetricsByService;
      final maxUsageByServices = state.memoryMetrics!.maxMetricsByService;

      // For each service, gather average and max usages
      for (final slice in averageUsageByServices.keys.sorted()) {
        final DiskSize averageUsage = DiskSize(
          byte: averageUsageByServices[slice]?.toInt() ?? 0,
        );
        final DiskSize maxUsage = DiskSize(
          byte: maxUsageByServices[slice]?.toInt() ?? 0,
        );

        children.add(
          ServiceMemoryConsumptionTile(
            averageUsage: averageUsage,
            maxUsage: maxUsage,
            slice: slice,
          ),
        );
      }
    }

    return BrandHeroScreen(
      heroTitle: 'resource_chart.memory'.tr(),
      children: [
        PeriodSelector(period: period, onChange: cubit.changePeriod),
        ...children,
      ],
    );
  }
}

class ServiceMemoryConsumptionTile extends StatelessWidget {
  const ServiceMemoryConsumptionTile({
    required this.averageUsage,
    required this.maxUsage,
    required this.slice,
    super.key,
  });

  const ServiceMemoryConsumptionTile.fake({
    super.key,
    this.averageUsage = const DiskSize(byte: 10),
    this.maxUsage = const DiskSize(byte: 10),
    this.slice = 'system',
  });

  final DiskSize averageUsage;
  final DiskSize maxUsage;
  final String slice;

  @override
  Widget build(final BuildContext context) {
    String? serviceName;
    Widget? icon;
    Function()? onTap;

    if (slice == 'system') {
      serviceName = 'resource_chart.system'.tr();
      icon = const Icon(BrandIcons.server);
    } else if (slice == 'user') {
      serviceName = 'resource_chart.ssh_users'.tr();
      icon = const Icon(BrandIcons.terminal);
    } else {
      final service = context.read<ServicesBloc>().state.getServiceById(
        slice.replaceAll('_', '-'),
      );
      serviceName = service?.displayName ?? slice;
      if (service != null) {
        onTap = () async {
          await context.pushRoute(ServiceRoute(serviceId: service.id));
        };
      }
      icon =
          service?.svgIcon != null
              ? SvgPicture.string(
                service!.svgIcon,
                width: 22,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              )
              : const Icon(BrandIcons.box);
    }

    if (serviceName == slice && averageUsage.byte == 0 && maxUsage.byte == 0) {
      return const SizedBox.shrink();
    }

    return ListTile(
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
      onTap: onTap,
    );
  }
}
