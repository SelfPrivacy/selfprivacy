import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/molecules/list_items/create_backup_checkbox_item.dart';

class CreateBackupsModal extends StatefulWidget {
  const CreateBackupsModal({
    required this.services,
    required this.scrollController,
    super.key,
  });

  final List<Service> services;
  final ScrollController scrollController;

  @override
  State<CreateBackupsModal> createState() => _CreateBackupsModalState();
}

class _CreateBackupsModalState extends State<CreateBackupsModal> {
  /// Store in state the selected services to backup
  List<Service> selectedServices = [];

  // Select all services on modal open
  @override
  void initState() {
    super.initState();
    final List<String> busyServices =
        context.read<ServerJobsBloc>().state.busyServices;
    selectedServices.addAll(
      widget.services.where(
        (final Service service) => !busyServices.contains(service.id),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final List<String> busyServices =
        context.watch<ServerJobsBloc>().state.busyServices;

    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'backup.create_new_select_heading'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Select all services tile
        CheckboxListTile.adaptive(
          onChanged: (final bool? value) {
            setState(() {
              if (value ?? true) {
                setState(() {
                  selectedServices
                    ..clear()
                    ..addAll(
                      widget.services.where(
                        (final service) => !busyServices.contains(service.id),
                      ),
                    );
                });
              } else {
                selectedServices.clear();
              }
            });
          },
          title: Text('backup.select_all'.tr()),
          secondary: const Icon(Icons.checklist_outlined),
          value:
              selectedServices.length >=
              widget.services.length - busyServices.length,
        ),
        const Divider(height: 1),
        ...widget.services.map(
          (final Service service) => CreateBackupCheckboxItem(
            service: service,
            busy: busyServices.contains(service.id),
            selected: selectedServices.contains(service),
            onChanged: (final bool? value) {
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
            },
          ),
        ),
        const SizedBox(height: 16),
        // Create backup button
        FilledButton(
          onPressed:
              selectedServices.isEmpty
                  ? null
                  : () {
                    context.read<BackupsBloc>().add(
                      CreateBackups(selectedServices),
                    );
                    Navigator.of(context).pop();
                  },
          child: Text('backup.start'.tr()),
        ),
      ],
    );
  }
}
