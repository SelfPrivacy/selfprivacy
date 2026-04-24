import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/service.dart';

class BasicEnumConfigItem extends StatefulWidget {
  const BasicEnumConfigItem({
    required this.configItem,
    required this.onChanged,
    this.newValue,
    super.key,
  });

  final EnumServiceConfigItem configItem;
  final Function(String) onChanged;
  final String? newValue;

  @override
  State<BasicEnumConfigItem> createState() => _BasicEnumConfigItemState();
}

class _BasicEnumConfigItemState extends State<BasicEnumConfigItem> {
  @override
  Widget build(final BuildContext context) {
    final List<DropdownMenuItem<String>> options =
        widget.configItem.options
            .map<DropdownMenuItem<String>>(
              (final String option) =>
                  DropdownMenuItem<String>(value: option, child: Text(option)),
            )
            .toList();
    if (!widget.configItem.options.contains(widget.configItem.value)) {
      options.add(
        DropdownMenuItem<String>(
          value: widget.configItem.value,
          enabled: false,
          child: Text(
            widget.configItem.value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.error.withAlpha(178),
            ),
          ),
        ),
      );
    }
    return Column(
      children: [
        ListTile(
          title: Text(widget.configItem.description),
          subtitle:
              (widget.newValue != null &&
                      widget.newValue != widget.configItem.value)
                  ? Text('service_page.modified'.tr())
                  : (!widget.configItem.options.contains(
                    widget.configItem.value,
                  ))
                  ? Text('service_page.invalid_value_detected'.tr())
                  : null,
          trailing: DropdownButton<String>(
            value: widget.newValue ?? widget.configItem.value,
            items: options,
            onChanged: (final String? value) {
              widget.onChanged(value!);
            },
          ),
        ),
      ],
    );
  }
}
