import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/cards/outlined_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@RoutePage()
class BackupDetailsPage extends StatefulWidget {
  const BackupDetailsPage({super.key});

  @override
  State<BackupDetailsPage> createState() => _BackupDetailsPageState();
}

class _BackupDetailsPageState extends State<BackupDetailsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    final bool isBackupInitialized =
        context.watch<BackupsCubit>().state.isInitialized;
    final StateType providerState = isReady && isBackupInitialized
        ? StateType.stable
        : StateType.uninitialized;
    final bool preventActions =
        context.watch<BackupsCubit>().state.preventActions;
    final List<Backup> backups = context.watch<BackupsCubit>().state.backups;
    final bool refreshing = context.watch<BackupsCubit>().state.refreshing;
    final List<Service> services =
        context.watch<ServicesCubit>().state.services;

    return BrandHeroScreen(
      heroIcon: BrandIcons.save,
      heroTitle: 'backup.card_title'.tr(),
      heroSubtitle: 'backup.description'.tr(),
      children: [
        if (isReady && !isBackupInitialized)
          BrandButton.rised(
            onPressed: preventActions
                ? null
                : () async {
                    await context.read<BackupsCubit>().initializeBackups();
                  },
            text: 'backup.initialize'.tr(),
          ),
        ListTile(
          onTap: preventActions
              ? null
              : () {
                  // await context.read<BackupsCubit>().createBackup();
                  showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (final BuildContext context) =>
                        DraggableScrollableSheet(
                      expand: false,
                      maxChildSize: 0.9,
                      minChildSize: 0.4,
                      initialChildSize: 0.6,
                      builder: (context, scrollController) =>
                          CreateBackupsModal(
                        services: services,
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
          leading: const Icon(
            Icons.add_circle_outline_rounded,
          ),
          title: Text(
            'backup.create_new'.tr(),
          ),
        ),
        const SizedBox(height: 16),
        // Card with a list of existing backups
        // Each list item has a date
        // When clicked, starts the restore action
        if (isBackupInitialized)
          OutlinedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.refresh,
                  ),
                  title: Text(
                    'backup.restore'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                if (backups.isEmpty)
                  ListTile(
                    leading: const Icon(
                      Icons.error_outline,
                    ),
                    title: Text('backup.no_backups'.tr()),
                  ),
                if (backups.isNotEmpty)
                  Column(
                    children: backups
                        .map(
                          (final Backup backup) => ListTile(
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
                                        context
                                            .read<BackupsCubit>()
                                            .restoreBackup(backup.id)
                                      },
                                    );
                                  },
                            title: Text(
                              '${MaterialLocalizations.of(context).formatShortDate(backup.time)} ${TimeOfDay.fromDateTime(backup.time).format(context)}',
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        OutlinedCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'backup.refresh'.tr(),
                ),
                onTap: refreshing
                    ? null
                    : () => {context.read<BackupsCubit>().updateBackups()},
                enabled: !refreshing,
              ),
              if (providerState != StateType.uninitialized)
                Column(
                  children: [
                    const Divider(
                      height: 1.0,
                    ),
                    ListTile(
                      title: Text(
                        'backup.refetch_backups'.tr(),
                      ),
                      onTap: preventActions
                          ? null
                          : () => {
                                context
                                    .read<BackupsCubit>()
                                    .forceUpdateBackups()
                              },
                    ),
                    const Divider(
                      height: 1.0,
                    ),
                    ListTile(
                      title: Text(
                        'backup.reupload_key'.tr(),
                      ),
                      onTap: preventActions
                          ? null
                          : () => {context.read<BackupsCubit>().reuploadKey()},
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreateBackupsModal extends StatefulWidget {
  const CreateBackupsModal({
    super.key,
    required this.services,
    required this.scrollController,
  });

  final List<Service> services;
  final ScrollController scrollController;

  @override
  State<CreateBackupsModal> createState() => _CreateBackupsModalState();
}

class _CreateBackupsModalState extends State<CreateBackupsModal> {
  // Store in state the selected services to backup
  List<Service> selectedServices = [];

  // Select all services on modal open
  @override
  void initState() {
    super.initState();
    final List<String> busyServices = context
        .read<ServerJobsCubit>()
        .state
        .backupJobList
        .where((final ServerJob job) =>
            job.status == JobStatusEnum.running ||
            job.status == JobStatusEnum.created)
        .map((final ServerJob job) => job.typeId.split('.')[1])
        .toList();
    selectedServices.addAll(widget.services
        .where((final Service service) => !busyServices.contains(service.id)));
  }

  @override
  Widget build(final BuildContext context) {
    final List<String> busyServices = context
        .watch<ServerJobsCubit>()
        .state
        .backupJobList
        .where((final ServerJob job) =>
            job.status == JobStatusEnum.running ||
            job.status == JobStatusEnum.created)
        .map((final ServerJob job) => job.typeId.split('.')[1])
        .toList();

    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'backup.create_new_select_headline'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Select all services tile
        CheckboxListTile(
          onChanged: (final bool? value) {
            setState(() {
              if (value ?? true) {
                setState(() {
                  selectedServices.clear();
                  selectedServices.addAll(widget.services.where(
                      (final service) => !busyServices.contains(service.id)));
                });
              } else {
                selectedServices.clear();
              }
            });
          },
          title: Text(
            'backup.select_all'.tr(),
          ),
          secondary: const Icon(
            Icons.checklist_outlined,
          ),
          value: selectedServices.length >=
              widget.services.length - busyServices.length,
        ),
        const Divider(
          height: 1.0,
        ),
        ...widget.services.map(
          (final Service service) {
            final bool busy = busyServices.contains(service.id);
            return CheckboxListTile(
              onChanged: !busy
                  ? (final bool? value) {
                      setState(() {
                        if (value ?? true) {
                          setState(() {
                            selectedServices.add(service);
                          });
                        } else {
                          setState(() {
                            selectedServices.remove(service);
                          });
                        }
                      });
                    }
                  : null,
              title: Text(
                service.displayName,
              ),
              subtitle: Text(
                busy ? 'backup.service_busy'.tr() : service.description,
              ),
              secondary: SvgPicture.string(
                service.svgIcon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  busy
                      ? Theme.of(context).colorScheme.outlineVariant
                      : Theme.of(context).colorScheme.onBackground,
                  BlendMode.srcIn,
                ),
              ),
              value: selectedServices.contains(service),
            );
          },
        ),
        const SizedBox(height: 16),
        // Create backup button
        FilledButton(
          onPressed: selectedServices.isEmpty
              ? null
              : () {
                  context
                      .read<BackupsCubit>()
                      .createMultipleBackups(selectedServices);
                  Navigator.of(context).pop();
                },
          child: Text(
            'backup.create'.tr(),
          ),
        ),
      ],
    );
  }
}
