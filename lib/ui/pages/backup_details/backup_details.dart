import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';
import 'package:easy_localization/easy_localization.dart';

part 'header.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class BackupDetails extends StatefulWidget {
  const BackupDetails({Key? key}) : super(key: key);

  @override
  _BackupDetailsState createState() => _BackupDetailsState();
}

class _BackupDetailsState extends State<BackupDetails>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<AppConfigCubit>().state is AppConfigFinished;
    var isBackupInitialized = context.watch<BackupsCubit>().state.isInitialized;
    var backupStatus = context.watch<BackupsCubit>().state.status;
    var providerState = isReady && isBackupInitialized
        ? (backupStatus == BackupStatusEnum.error
            ? StateType.warning
            : StateType.stable)
        : StateType.uninitialized;
    var preventActions = context.watch<BackupsCubit>().state.preventActions;
    var backupProgress = context.watch<BackupsCubit>().state.progress;
    var backupError = context.watch<BackupsCubit>().state.error;
    var backups = context.watch<BackupsCubit>().state.backups;
    var refreshing = context.watch<BackupsCubit>().state.refreshing;

    return Scaffold(
      appBar: PreferredSize(
        child: Column(
          children: [
            Container(
              height: 51,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: BrandText.h4('basis.details'.tr()),
            ),
            BrandDivider(),
          ],
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: paddingH15V0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(
                    providerState: providerState,
                    refreshing: refreshing,
                  ),
                  SizedBox(height: 10),
                  BrandText.h2('providers.backup.card_title'.tr()),
                  SizedBox(height: 10),
                  BrandText.body1('providers.backup.bottom_sheet.1'.tr()),
                  SizedBox(height: 20),
                  if (isReady && !isBackupInitialized)
                    BrandButton.rised(
                      onPressed: preventActions
                          ? null
                          : () async {
                              await context.read<BackupsCubit>().createBucket();
                            },
                      text: 'providers.backup.initialize'.tr(),
                    ),
                  if (backupStatus == BackupStatusEnum.initializing)
                    BrandText.body1('providers.backup.waitingForRebuild'.tr()),
                  if (backupStatus != BackupStatusEnum.initializing &&
                      backupStatus != BackupStatusEnum.noKey)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (backupStatus == BackupStatusEnum.initialized)
                            ListTile(
                              onTap: preventActions
                                  ? null
                                  : () async {
                                      await context
                                          .read<BackupsCubit>()
                                          .createBackup();
                                    },
                              leading: Icon(
                                Icons.add_circle_outline_rounded,
                                color: BrandColors.textColor1,
                              ),
                              title: BrandText.h5(
                                  'providers.backup.create_new'.tr()),
                            ),
                          if (backupStatus == BackupStatusEnum.backingUp)
                            ListTile(
                              title: BrandText.h5('providers.backup.creating'
                                  .tr(args: [
                                (backupProgress * 100).round().toString()
                              ])),
                              subtitle: LinearProgressIndicator(
                                value: backupProgress,
                                backgroundColor: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          if (backupStatus == BackupStatusEnum.restoring)
                            ListTile(
                              title: BrandText.h5('providers.backup.restoring'
                                  .tr(args: [
                                (backupProgress * 100).round().toString()
                              ])),
                              subtitle: LinearProgressIndicator(
                                backgroundColor: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          if (backupStatus == BackupStatusEnum.error)
                            ListTile(
                              leading: Icon(
                                Icons.error_outline,
                                color: BrandColors.red1,
                              ),
                              title: BrandText.h5(
                                  'providers.backup.error_pending'.tr()),
                            ),
                        ],
                      ),
                    ),
                  SizedBox(height: 16),
                  // Card with a list of existing backups
                  // Each list item has a date
                  // When clicked, starts the restore action
                  if (backupStatus != BackupStatusEnum.initializing &&
                      backupStatus != BackupStatusEnum.noKey)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.refresh,
                              color: BrandColors.textColor1,
                            ),
                            title:
                                BrandText.h5('providers.backup.restore'.tr()),
                          ),
                          Divider(
                            height: 1.0,
                          ),
                          if (backups.isEmpty)
                            ListTile(
                              leading: Icon(
                                Icons.error_outline,
                              ),
                              title: Text('providers.backup.no_backups'.tr()),
                            ),
                          if (backups.isNotEmpty)
                            Column(
                              children: backups.map((backup) {
                                return ListTile(
                                  onTap: preventActions
                                      ? null
                                      : () {
                                          var nav = getIt<NavigationService>();
                                          nav.showPopUpDialog(BrandAlert(
                                            title: 'providers.backup.restoring'
                                                .tr(),
                                            contentText:
                                                'providers.backup.restore_alert'
                                                    .tr(args: [
                                              backup.time.toString()
                                            ]),
                                            actions: [
                                              ActionButton(
                                                text: 'basis.cancel'.tr(),
                                              ),
                                              ActionButton(
                                                onPressed: () => {
                                                  context
                                                      .read<BackupsCubit>()
                                                      .restoreBackup(backup.id)
                                                },
                                                text: 'modals.yes'.tr(),
                                              )
                                            ],
                                          ));
                                        },
                                  title: Text(
                                    MaterialLocalizations.of(context)
                                            .formatShortDate(backup.time) +
                                        ' ' +
                                        TimeOfDay.fromDateTime(backup.time)
                                            .format(context),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  if (backupStatus == BackupStatusEnum.error)
                    BrandText.body1(backupError.toString()),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
