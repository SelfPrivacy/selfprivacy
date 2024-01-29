import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/backups/snapshot_modal.dart';

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
        ? context.watch<BackupsBloc>().state.backups
        : context.watch<BackupsBloc>().state.serviceBackups(service!.id);
    final bool preventActions =
        context.watch<BackupsBloc>().state.preventActions;
    return BrandHeroScreen(
      heroTitle: 'backup.snapshots_title'.tr(),
      hasFlashButton: true,
      children: [
        if (backups.isEmpty)
          Center(
            child: Text(
              'backup.no_backups'.tr(),
            ),
          )
        else
          ...backups.map(
            (final Backup backup) {
              final service = context
                  .read<ServicesBloc>()
                  .state
                  .getServiceById(backup.serviceId);
              return ListTile(
                onTap: preventActions
                    ? null
                    : () {
                        showModalBottomSheet(
                          useRootNavigator: true,
                          context: context,
                          isScrollControlled: true,
                          builder: (final BuildContext context) =>
                              DraggableScrollableSheet(
                            expand: false,
                            maxChildSize: 0.9,
                            minChildSize: 0.5,
                            initialChildSize: 0.7,
                            builder: (final context, final scrollController) =>
                                SnapshotModal(
                              snapshot: backup,
                              scrollController: scrollController,
                            ),
                          ),
                        );
                      },
                onLongPress: preventActions
                    ? null
                    : () {
                        showPopUpAlert(
                          alertTitle: 'backup.forget_snapshot'.tr(),
                          description: 'backup.forget_snapshot_alert'.tr(),
                          actionButtonTitle: 'backup.forget_snapshot'.tr(),
                          actionButtonOnPressed: () => {
                            context
                                .read<BackupsBloc>()
                                .add(ForgetSnapshot(backup.id)),
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
            },
          ),
      ],
    );
  }
}
