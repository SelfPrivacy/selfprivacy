import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class MigrationProcessPage extends StatefulWidget {
  const MigrationProcessPage({
    required this.jobUid,
    final super.key,
  });

  final String jobUid;

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
    final serverJobsState = context.watch<ServerJobsCubit>().state;
    final ServerJob job = serverJobsState.serverJobList.firstWhere(
      (final ServerJob job) => job.uid == widget.jobUid,
    );
    final double value = job.progress == null ? 0.0 : job.progress! / 100;
    return BrandHeroScreen(
      hasBackButton: false,
      heroTitle: 'providers.storage.migration_process'.tr(),
      heroSubtitle: job.statusText,
      children: [
        BrandLinearIndicator(
          value: value,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          height: 14.0,
        ),
        const SizedBox(height: 16),
        if (job.finishedAt != null)
          Text(
            job.result!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (job.finishedAt != null) const SizedBox(height: 16),
        if (job.finishedAt != null)
          FilledButton(
            title: 'providers.storage.migration_done'.tr(),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                materialRoute(const RootPage()),
                (final predicate) => false,
              );
            },
          )
      ],
    );
  }
}
