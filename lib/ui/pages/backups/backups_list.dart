import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/list_items/snapshot_item.dart';

@RoutePage()
class BackupsListPage extends StatelessWidget {
  const BackupsListPage({required this.service, super.key});

  final Service? service;

  @override
  Widget build(final BuildContext context) {
    // If the service is null, get all backups from state. If not null, call the
    // serviceBackups(serviceId) on the backups state.
    final List<Backup> backups =
        service == null
            ? context.watch<BackupsBloc>().state.backups
            : context.watch<BackupsBloc>().state.serviceBackups(service!.id);
    final bool preventActions =
        context.watch<BackupsBloc>().state.preventActions;
    return BrandHeroScreen(
      heroTitle: 'backup.snapshots_title'.tr(),
      hasFlashButton: true,
      children: [
        if (backups.isEmpty)
          Center(child: Text('backup.no_backups'.tr()))
        else
          ...backups.map(
            (final Backup backup) =>
                SnapshotItem(backup: backup, preventActions: preventActions),
          ),
      ],
    );
  }
}
