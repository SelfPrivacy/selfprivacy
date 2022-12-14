import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/provider_volumes/provider_volume_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_volumes/server_volume_cubit.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

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
  double _euroPerGb = 1.0;

  final DiskSize maxSize = const DiskSize(byte: 500000000000);
  late DiskSize minSize;

  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _updateErrorStatuses() {
    _isError = minSize.gibibyte > _currentSliderGbValue;
  }

  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future: context.read<ApiProviderVolumeCubit>().getPricePerGb(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<void> snapshot,
        ) {
          if (!snapshot.hasData) {
            return BrandHeroScreen(
              hasBackButton: true,
              heroTitle: 'storage.extending_volume_title'.tr(),
              heroSubtitle: 'storage.extending_volume_description'.tr(),
              children: const [
                SizedBox(height: 16),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          _euroPerGb = (snapshot.data as Price).value;
          _sizeController.text = _currentSliderGbValue.truncate().toString();
          _priceController.text =
              (_euroPerGb * double.parse(_sizeController.text))
                  .toStringAsFixed(2);
          minSize =
              widget.diskVolumeToResize.sizeTotal + DiskSize.fromGibibyte(3);
          if (_currentSliderGbValue < 0) {
            _currentSliderGbValue = minSize.gibibyte;
          }

          final isAlreadyResizing =
              context.watch<ApiProviderVolumeCubit>().state.isResizing;

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
                        labelText: 'storage.euro'.tr(),
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
              FilledButton(
                title: 'storage.extend_volume_button.title'.tr(),
                onPressed: _isError
                    ? null
                    : () {
                        context.read<ApiProviderVolumeCubit>().resizeVolume(
                              widget.diskVolumeToResize,
                              DiskSize.fromGibibyte(_currentSliderGbValue),
                              context.read<ApiServerVolumeCubit>().reload,
                            );
                        Navigator.of(context).pushAndRemoveUntil(
                          materialRoute(const RootPage()),
                          (final predicate) => false,
                        );
                      },
                disabled: _isError || isAlreadyResizing,
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 1.0,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.info_outlined,
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text('storage.extending_volume_price_info'.tr()),
              const SizedBox(height: 16),
            ],
          );
        },
      );
}
