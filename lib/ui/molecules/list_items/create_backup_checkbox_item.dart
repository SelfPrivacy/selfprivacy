import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/models/service.dart';

class CreateBackupCheckboxItem extends StatelessWidget {
  const CreateBackupCheckboxItem({
    required this.service,
    required this.busy,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final Service service;
  final bool busy;
  final bool selected;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool?) onChanged;

  @override
  Widget build(final BuildContext context) {
    final List<Widget> descriptionWidgets = [];
    if (busy) {
      descriptionWidgets.add(Text('backup.service_busy'.tr()));
    } else {
      descriptionWidgets
        ..add(
          Text(
            'service_page.uses'.tr(
              namedArgs: {
                'usage': service.storageUsage.used.toString(),
                'volume':
                    context
                        .read<VolumesBloc>()
                        .state
                        .getVolume(service.storageUsage.volume ?? '')
                        .displayName,
              },
            ),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        )
        ..add(Text(service.backupDescription));
    }
    return CheckboxListTile.adaptive(
      onChanged: !busy ? onChanged : null,
      title: Text(service.displayName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: descriptionWidgets,
      ),
      isThreeLine: true,
      secondary: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: SvgPicture.string(
          service.svgIcon,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            busy
                ? Theme.of(context).colorScheme.outlineVariant
                : Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
      value: selected,
    );
  }
}
