import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';

class ChangeAutobackupsPeriodModal extends StatefulWidget {
  const ChangeAutobackupsPeriodModal({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  State<ChangeAutobackupsPeriodModal> createState() =>
      _ChangeAutobackupsPeriodModalState();
}

class _ChangeAutobackupsPeriodModalState
    extends State<ChangeAutobackupsPeriodModal> {
  Duration? selectedPeriod;

  static const List<Duration> autobackupPeriods = [
    Duration(hours: 12),
    Duration(days: 1),
    Duration(days: 2),
    Duration(days: 3),
    Duration(days: 7),
  ];

  // Set initial period to the one currently set
  @override
  void initState() {
    super.initState();
    selectedPeriod = context.read<BackupsBloc>().state.autobackupPeriod;
  }

  @override
  Widget build(final BuildContext context) {
    final Duration? initialAutobackupPeriod =
        context.watch<BackupsBloc>().state.autobackupPeriod;
    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'backup.autobackup_period_title'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Select all services tile
        RadioListTile<Duration?>.adaptive(
          onChanged: (final Duration? value) {
            setState(() {
              selectedPeriod = value;
            });
          },
          title: Text('backup.autobackup_period_disable'.tr()),
          value: null,
          groupValue: selectedPeriod,
        ),
        const Divider(height: 1),
        ...autobackupPeriods.map(
          (final Duration period) => RadioListTile<Duration?>.adaptive(
            onChanged: (final Duration? value) {
              setState(() {
                selectedPeriod = value;
              });
            },
            title: Text(
              'backup.autobackup_period_every'.tr(
                namedArgs: {'period': period.toPrettyString(context.locale)},
              ),
            ),
            value: period,
            groupValue: selectedPeriod,
          ),
        ),
        const SizedBox(height: 16),
        // Create backup button
        FilledButton(
          onPressed:
              selectedPeriod == initialAutobackupPeriod
                  ? null
                  : () {
                    context.read<BackupsBloc>().add(
                      SetAutobackupPeriod(selectedPeriod),
                    );
                    Navigator.of(context).pop();
                  },
          child: Text('backup.autobackup_set_period'.tr()),
        ),
      ],
    );
  }
}
