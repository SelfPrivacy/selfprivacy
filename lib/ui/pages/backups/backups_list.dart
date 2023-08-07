import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

@RoutePage()
class BackupsListPage extends StatelessWidget {
  const BackupsListPage({
    required this.service,
    super.key,
  });

  final Service? service;

  @override
  Widget build(final BuildContext context) {
    // If the service is null, get all backups from state. If not null, call the
    // serviceBackups(serviceId) on the backups state.
    final List<Backup> backups = service == null
        ? context.watch<BackupsCubit>().state.backups
        : context.watch<BackupsCubit>().state.serviceBackups(service!.id);
    final bool preventActions =
        context.watch<BackupsCubit>().state.preventActions;
    return BrandHeroScreen(
      heroTitle: 'backup.snapshots_title'.tr(),
      children: [
        if (backups.isEmpty)
          Center(
            child: Text(
              'backup.no_backups'.tr(),
            ),
          )
        else
          ...backups.map((final Backup backup) {
            final service = context
                .read<ServicesCubit>()
                .state
                .getServiceById(backup.serviceId);
            return ListTile(
              onTap: preventActions
                  ? null
                  : () {
                      showPopUpAlert(
                        alertTitle: 'backup.restoring'.tr(),
                        description: 'backup.restore_alert'.tr(
                          args: [backup.time.toString()],
                        ),
                        actionButtonTitle: 'modals.yes'.tr(),
                        actionButtonOnPressed: () => {
                          context.read<BackupsCubit>().restoreBackup(
                                backup.id, // TODO: inex
                                BackupRestoreStrategy.unknown,
                              )
                        },
                      );
                    },
              title: Text(
                '${MaterialLocalizations.of(context).formatShortDate(backup.time)} ${TimeOfDay.fromDateTime(backup.time).format(context)}',
              ),
              subtitle: Text(
                service?.displayName ?? backup.fallbackServiceName,
              ),
              leading: service != null
                  ? SvgPicture.string(
                      service.svgIcon,
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onBackground,
                        BlendMode.srcIn,
                      ),
                    )
                  : const Icon(
                      Icons.question_mark_outlined,
                    ),
            );
          })
      ],
    );
  }
}
