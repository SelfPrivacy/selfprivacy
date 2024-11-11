import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/service.dart';

class DomainStringConfigItem extends StatefulWidget {
  const DomainStringConfigItem({
    required this.configItem,
    required this.onChanged,
    this.newValue,
    super.key,
  });

  final StringServiceConfigItem configItem;
  final Function(String, bool) onChanged;
  final String? newValue;

  @override
  State<DomainStringConfigItem> createState() => _DomainStringConfigItemState();
}

class _DomainStringConfigItemState extends State<DomainStringConfigItem> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.newValue ?? widget.configItem.value;
    _controller.addListener(() {
      final String value = _controller.text;
      final bool isValid = _validateInput(value);
      if (isValid) {
        setState(() {
          widget.onChanged(value, isValid);
          _isValid = isValid;
        });
      } else {
        setState(() {
          widget.onChanged(widget.newValue ?? widget.configItem.value, isValid);
          _isValid = isValid;
        });
      }
    });
  }

  bool _validateInput(final String value) {
    if (value == '') {
      return false;
    }
    final regexPattern = widget.configItem.regex;
    if (regexPattern == null) {
      return true;
    }
    final regex = RegExp(regexPattern);
    return regex.hasMatch(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final String domain =
        getIt<ResourcesModel>().serverDomain?.domainName ?? '';

    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.configItem.description,
            hintText: widget.configItem.value,
            suffixText: '.$domain',
            counter: _controller.text != widget.configItem.value
                ? InkWell(
                    onTap: () {
                      _controller.text = widget.configItem.value;
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'service_page.modified'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const Gap(8.0),
                        Icon(
                          Icons.undo_outlined,
                          size: 16.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  )
                : Text(
                    ' ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
            border: const OutlineInputBorder(),
            errorText: _isValid ? null : 'service_page.invalid_input'.tr(),
          ),
        ),
      ],
    );
  }
}
