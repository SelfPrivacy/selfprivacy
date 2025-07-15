import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/organisms/modals/backups/snapshot_modal.dart';

class SnapshotItem extends StatelessWidget {
  const SnapshotItem({
    required this.backup,
    required this.preventActions,
    this.overrideColor,
    super.key,
  });

  final Backup backup;
  final bool preventActions;
  final Color? overrideColor;

  @override
  Widget build(final BuildContext context) {
    final service = context.read<ServicesBloc>().state.getServiceById(
      backup.serviceId,
    );

    return ListTile(
      onTap:
          preventActions
              ? null
              : () async {
                await showModalBottomSheet(
                  useRootNavigator: true,
                  context: context,
                  isScrollControlled: true,
                  builder:
                      (final BuildContext context) => DraggableScrollableSheet(
                        expand: false,
                        maxChildSize: 0.9,
                        minChildSize: 0.5,
                        initialChildSize: 0.7,
                        builder:
                            (final context, final scrollController) =>
                                SnapshotModal(
                                  snapshot: backup,
                                  scrollController: scrollController,
                                ),
                      ),
                );
              },
      onLongPress:
          preventActions
              ? null
              : () {
                showPopUpAlert(
                  alertTitle: 'backup.forget_snapshot'.tr(),
                  description: 'backup.forget_snapshot_alert'.tr(),
                  actionButtonTitle: 'backup.forget_snapshot'.tr(),
                  actionButtonOnPressed:
                      () => context.read<BackupsBloc>().add(
                        ForgetSnapshot(backup.id),
                      ),
                );
              },
      title: Text(
        style: TextStyle(color: overrideColor),
        '${MaterialLocalizations.of(context).formatShortDate(backup.time.toLocal())} ${TimeOfDay.fromDateTime(backup.time.toLocal()).format(context)}',
      ),
      subtitle: Text(
        style: TextStyle(color: overrideColor),
        service?.displayName ?? backup.fallbackServiceName,
      ),
      leading:
          service != null
              ? SvgPicture.string(
                service.svgIcon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  overrideColor ?? Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              )
              : Icon(Icons.question_mark_outlined, color: overrideColor),
    );
  }
}
