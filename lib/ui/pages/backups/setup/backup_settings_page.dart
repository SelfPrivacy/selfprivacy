import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/backups_wizard/backups_wizard_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';
import 'package:selfprivacy/ui/pages/backups/change_period_modal.dart';
import 'package:selfprivacy/ui/pages/backups/change_rotation_quotas_modal.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';

class BackupSettingsPage extends StatelessWidget {
  const BackupSettingsPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final cubit = context.watch<BackupsWizardCubit>();
    final autobackupPeriod = cubit.state.autobackupPeriod;
    return ResponsiveLayoutWithInfobox(
      topChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'backup.settings.initialize_settings_title'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      primaryColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ListTile(
            onTap: () {
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
                  builder: (final context, final scrollController) =>
                      ChangeAutobackupsPeriodModal(
                    initialAutobackupPeriod: null,
                    onSetPeriodCallback: (final Duration? selectedPeriod) =>
                        context
                            .read<BackupsWizardCubit>()
                            .setAutobackupPeriod(selectedPeriod),
                    scrollController: scrollController,
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.manage_history_outlined,
            ),
            title: Text(
              'backup.autobackup_period_title'.tr(),
            ),
            subtitle: Text(
              autobackupPeriod != null
                  ? 'backup.autobackup_period_subtitle'.tr(
                      namedArgs: {
                        'period':
                            autobackupPeriod.toPrettyString(context.locale)
                      },
                    )
                  : 'backup.autobackup_period_never'.tr(),
            ),
          ),
          ListTile(
            onTap: () {
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
                  builder: (final context, final scrollController) =>
                      ChangeRotationQuotasModal(
                    initialAutobackupQuotas: null,
                    onSetAutobackupQuotasCallback:
                        (final AutobackupQuotas selectedAutobackupQuotas) =>
                            context
                                .read<BackupsWizardCubit>()
                                .setAutobackupQuotas(selectedAutobackupQuotas),
                    scrollController: scrollController,
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.auto_delete_outlined,
            ),
            title: Text(
              'backup.rotation_quotas_title'.tr(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () =>
                context.read<BackupsWizardCubit>().confirmSettings(),
            child: Text(
              'backup.set_rotation_quotas'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
