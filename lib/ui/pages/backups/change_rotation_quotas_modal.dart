import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/backup.dart';

class ChangeRotationQuotasModal extends StatefulWidget {
  const ChangeRotationQuotasModal({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  State<ChangeRotationQuotasModal> createState() =>
      _ChangeRotationQuotasModalState();
}

enum QuotaUnits {
  last,
  daily,
  weekly,
  monthly,
  yearly,
}

class _ChangeRotationQuotasModalState extends State<ChangeRotationQuotasModal> {
  AutobackupQuotas selectedQuotas = AutobackupQuotas(
    last: 3,
    daily: 7,
    weekly: 4,
    monthly: 6,
    yearly: -1,
  );

  // Set initial period to the one currently set
  @override
  void initState() {
    super.initState();
    selectedQuotas =
        context.read<BackupsCubit>().state.autobackupQuotas ?? selectedQuotas;
  }

  String generateSubtitle(final int value, final QuotaUnits unit) {
    switch (unit) {
      case QuotaUnits.last:
        return value == -1
            ? 'backup.quota_subtitles.last_infinite'.tr()
            : 'backup.quota_subtitles.last'.plural(value);
      case QuotaUnits.daily:
        if (selectedQuotas.last == -1) {
          return 'backup.quota_subtitles.no_effect'.tr();
        }
        return value == -1
            ? 'backup.quota_subtitles.daily_infinite'.tr()
            : 'backup.quota_subtitles.daily'.plural(value);
      case QuotaUnits.weekly:
        if (selectedQuotas.last == -1 || selectedQuotas.daily == -1) {
          return 'backup.quota_subtitles.no_effect'.tr();
        }
        return value == -1
            ? 'backup.quota_subtitles.weekly_infinite'.tr()
            : 'backup.quota_subtitles.weekly'.plural(value);
      case QuotaUnits.monthly:
        if (selectedQuotas.last == -1 || selectedQuotas.daily == -1) {
          return 'backup.quota_subtitles.no_effect'.tr();
        }
        return value == -1
            ? 'backup.quota_subtitles.monthly_infinite'.tr()
            : 'backup.quota_subtitles.monthly'.plural(value);
      case QuotaUnits.yearly:
        if (selectedQuotas.last == -1 || selectedQuotas.daily == -1) {
          return 'backup.quota_subtitles.no_effect'.tr();
        }
        return value == -1
            ? 'backup.quota_subtitles.yearly_infinite'.tr()
            : 'backup.quota_subtitles.yearly'.plural(value);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final AutobackupQuotas? initialAutobackupQuotas =
        context.watch<BackupsCubit>().state.autobackupQuotas;
    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'backup.rotation_quotas_title'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'backup.quotas_only_applied_to_autobackups'.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Accordions for each quota type. When tapped allows to enter a new int value
        // for the quota.
        QuotaSelectionTile(
          title: 'backup.quota_titles.last'.tr(),
          subtitle: generateSubtitle(selectedQuotas.last, QuotaUnits.last),
          value: selectedQuotas.last,
          min: 1,
          max: 30,
          callback: (final double value) {
            setState(() {
              if (value == 31) {
                selectedQuotas = selectedQuotas.copyWith(last: -1);
                return;
              }
              selectedQuotas = selectedQuotas.copyWith(last: value.toInt());
            });
          },
        ),
        QuotaSelectionTile(
          title: 'backup.quota_titles.daily'.tr(),
          subtitle: generateSubtitle(selectedQuotas.daily, QuotaUnits.daily),
          value: selectedQuotas.daily,
          min: 0,
          max: 30,
          callback: (final double value) {
            setState(() {
              if (value == 31) {
                selectedQuotas = selectedQuotas.copyWith(daily: -1);
                return;
              }
              selectedQuotas = selectedQuotas.copyWith(daily: value.toInt());
            });
          },
        ),
        QuotaSelectionTile(
          title: 'backup.quota_titles.weekly'.tr(),
          subtitle: generateSubtitle(selectedQuotas.weekly, QuotaUnits.weekly),
          value: selectedQuotas.weekly,
          min: 0,
          max: 15,
          callback: (final double value) {
            setState(() {
              if (value == 16) {
                selectedQuotas = selectedQuotas.copyWith(weekly: -1);
                return;
              }
              selectedQuotas = selectedQuotas.copyWith(weekly: value.toInt());
            });
          },
        ),
        QuotaSelectionTile(
          title: 'backup.quota_titles.monthly'.tr(),
          subtitle:
              generateSubtitle(selectedQuotas.monthly, QuotaUnits.monthly),
          value: selectedQuotas.monthly,
          min: 0,
          max: 24,
          callback: (final double value) {
            setState(() {
              if (value == 25) {
                selectedQuotas = selectedQuotas.copyWith(monthly: -1);
                return;
              }
              selectedQuotas = selectedQuotas.copyWith(monthly: value.toInt());
            });
          },
        ),
        QuotaSelectionTile(
          title: 'backup.quota_titles.yearly'.tr(),
          subtitle: generateSubtitle(selectedQuotas.yearly, QuotaUnits.yearly),
          value: selectedQuotas.yearly,
          min: 0,
          max: 5,
          callback: (final double value) {
            setState(() {
              if (value == 6) {
                selectedQuotas = selectedQuotas.copyWith(yearly: -1);
                return;
              }
              selectedQuotas = selectedQuotas.copyWith(yearly: value.toInt());
            });
          },
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: selectedQuotas == initialAutobackupQuotas
              ? null
              : () {
                  context
                      .read<BackupsCubit>()
                      .setAutobackupQuotas(selectedQuotas);
                  Navigator.of(context).pop();
                },
          child: Text(
            'backup.set_rotation_quotas'.tr(),
          ),
        ),
      ],
    );
  }
}

class QuotaSelectionTile extends StatelessWidget {
  const QuotaSelectionTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.max,
    required this.callback,
    super.key,
  });

  final String title;
  final String subtitle;
  final int value;
  final int min;
  final int max;
  final void Function(double) callback;

  @override
  Widget build(final BuildContext context) => ExpansionTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          value == -1 ? '∞' : value.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        children: [
          // Discrete slider to select the new value
          if (value >= -1 && value <= max)
            Slider(
              value: value == -1 ? max + 1 : value.toDouble(),
              min: min.toDouble(),
              max: (max + 1).toDouble(),
              divisions: max - min + 1,
              label: value == -1 ? '∞' : value.toString(),
              onChanged: callback,
            ),
          if (value < -1 || value > max)
            Text(
              'Manually set to $value',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
        ],
      );
}
