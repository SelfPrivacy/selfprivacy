part of '../service_settings_page.dart';

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
  Widget build(final BuildContext context) => Column(
        children: [
          ListTile(
            title: Text(widget.configItem.description),
            subtitle: (widget.newValue != null &&
                    widget.newValue != widget.configItem.value)
                ? Text('service_page.modified'.tr())
                : null,
            trailing: DropdownButton<String>(
              value: widget.newValue ?? widget.configItem.value,
              items: widget.configItem.options
                  .map<DropdownMenuItem<String>>(
                    (final String option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: (final String? value) {
                widget.onChanged(value!);
              },
            ),
          ),
        ],
      );
}
