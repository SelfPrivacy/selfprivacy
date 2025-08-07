import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/service.dart';

class BasicBoolConfigItem extends StatefulWidget {
  const BasicBoolConfigItem({
    required this.configItem,
    required this.onChanged,
    this.newValue,
    super.key,
  });

  final BoolServiceConfigItem configItem;
  // ignore: avoid_positional_boolean_parameters
  final Function(bool) onChanged;
  final bool? newValue;

  @override
  State<BasicBoolConfigItem> createState() => _BasicBoolConfigItemState();
}

class _BasicBoolConfigItemState extends State<BasicBoolConfigItem> {
  @override
  Widget build(final BuildContext context) => Column(
    children: [
      SwitchListTile.adaptive(
        title: Text(widget.configItem.description),
        subtitle:
            (widget.newValue != null &&
                    widget.newValue != widget.configItem.value)
                ? Text('service_page.modified'.tr())
                : null,
        value: widget.newValue ?? widget.configItem.value,
        onChanged: (final bool value) {
          widget.onChanged(value);
        },
      ),
    ],
  );
}
