import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class MigrationProcessPage extends StatefulWidget {
  const MigrationProcessPage({super.key});

  @override
  State<MigrationProcessPage> createState() => _MigrationProcessPageState();
}

class _MigrationProcessPageState extends State<MigrationProcessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    ServerJob? job;
    String? subtitle = '';
    double value = 0.0;
    List<Widget> children = [];

    final serverJobsState = context.watch<ServerJobsCubit>().state;
    if (serverJobsState.migrationJobUid != null) {
      job = context.read<ServerJobsCubit>().getServerJobByUid(
            serverJobsState.migrationJobUid!,
          );
    }

    if (job == null) {
      subtitle = 'basis.loading'.tr();
    } else {
      value = job.progress == null ? 0.0 : job.progress! / 100;
      subtitle = job.statusText;
      children = [
        ...children,
        const SizedBox(height: 16),
        if (job.finishedAt != null)
          Text(
            job.result!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (job.finishedAt != null) const SizedBox(height: 16),
        if (job.finishedAt != null)
          BrandButton.filled(
            child: Text('storage.migration_done'.tr()),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                materialRoute(const RootPage()),
                (final predicate) => false,
              );
            },
          ),
      ];
    }
    return BrandHeroScreen(
      hasBackButton: false,
      heroTitle: 'storage.migration_process'.tr(),
      heroSubtitle: subtitle,
      children: [
        BrandLinearIndicator(
          value: value,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          height: 4.0,
        ),
        ...children,
      ],
    );
  }
}
