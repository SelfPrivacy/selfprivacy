import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';

@RoutePage()
class ExtendingVolumePage extends StatefulWidget {
  const ExtendingVolumePage({
    required this.diskVolumeToResize,
    required this.diskStatus,
    super.key,
  });

  final DiskVolume diskVolumeToResize;
  final DiskStatus diskStatus;

  @override
  State<ExtendingVolumePage> createState() => _ExtendingVolumePageState();
}

class _ExtendingVolumePageState extends State<ExtendingVolumePage> {
  @override
  void initState() {
    minSize = widget.diskVolumeToResize.sizeTotal + DiskSize.fromGibibyte(3);
    _currentSliderGbValue = minSize.gibibyte;
    super.initState();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  bool _isError = false;

  late double _currentSliderGbValue;
  double _pricePerGb = 1;

  final DiskSize maxSize = const DiskSize(byte: 500000000000);
  late DiskSize minSize;

  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _updateErrorStatuses() {
    _isError = minSize.gibibyte > _currentSliderGbValue;
  }

  @override
  Widget build(final BuildContext context) => FutureBuilder(
    future: context.read<VolumesBloc>().getPricePerGb(),
    builder: (
      final BuildContext context,
      final AsyncSnapshot<Price?> snapshot,
    ) {
      if (!snapshot.hasData) {
        return BrandHeroScreen(
          hasBackButton: true,
          heroTitle: 'storage.extending_volume_title'.tr(),
          heroSubtitle: 'storage.extending_volume_description'.tr(),
          children: const [
            SizedBox(height: 16),
            Center(child: CircularProgressIndicator.adaptive()),
          ],
        );
      }
      final price = snapshot.data!;
      _pricePerGb = price.value;
      final currentSizeValue = _currentSliderGbValue.truncate().toString();
      _sizeController.text = 'storage.gb'.tr(args: [currentSizeValue]);
      _priceController.text =
          '${(_pricePerGb * double.parse(currentSizeValue)).toStringAsFixed(2)}'
          ' '
          '${price.currency.shortcode}';
      minSize = widget.diskVolumeToResize.sizeTotal + DiskSize.fromGibibyte(3);
      if (_currentSliderGbValue < 0) {
        _currentSliderGbValue = minSize.gibibyte;
      }

      final isAlreadyResizing =
          context.watch<VolumesBloc>().state is VolumesResizing;

      return BrandHeroScreen(
        hasBackButton: true,
        heroTitle: 'storage.extending_volume_title'.tr(),
        heroSubtitle: 'storage.extending_volume_description'.tr(),
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 130),
                child: TextField(
                  readOnly: true,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  controller: _sizeController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    errorText: _isError ? ' ' : null,
                    labelText: 'storage.size'.tr(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 130),
                child: TextField(
                  readOnly: true,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    errorText: _isError ? ' ' : null,
                    labelText: 'storage.price'.tr(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            min: minSize.gibibyte,
            value: _currentSliderGbValue,
            max: maxSize.gibibyte,
            onChanged: (final double value) {
              setState(() {
                _currentSliderGbValue = value;
                _updateErrorStatuses();
              });
            },
          ),
          const SizedBox(height: 16),
          BrandButton.filled(
            onPressed:
                _isError || isAlreadyResizing
                    ? null
                    : () {
                      showPopUpAlert(
                        alertTitle: 'storage.extending_volume_title'.tr(),
                        description:
                            'storage.extending_volume_modal_description'.tr(
                              namedArgs: {
                                'size': _sizeController.text,
                                'price': _priceController.text,
                              },
                            ),
                        actionButtonTitle: 'basis.continue'.tr(),
                        actionButtonOnPressed: () {
                          context.read<VolumesBloc>().add(
                            VolumeResize(
                              widget.diskVolumeToResize,
                              DiskSize.fromGibibyte(
                                _currentSliderGbValue.truncate().toDouble(),
                              ),
                            ),
                          );
                          context.router.popUntilRoot();
                        },
                      );
                    },
            child: Text('storage.extend_volume_button.title'.tr()),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          InfoBox(
            text: 'storage.extending_volume_price_info'.tr(),
            isWarning: false,
          ),
          const SizedBox(height: 16),
        ],
      );
    },
  );
}
