part of '../service_settings_page.dart';

class BasicBoolConfigItem extends StatefulWidget {
  const BasicBoolConfigItem({
    required this.configItem,
    required this.onChanged,
    this.newValue,
    super.key,
  });

  final BoolServiceConfigItem configItem;
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
            subtitle: (widget.newValue != null &&
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
