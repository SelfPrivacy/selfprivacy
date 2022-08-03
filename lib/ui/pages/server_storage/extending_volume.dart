import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/volumes/volumes_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';

class ExtendingVolumePage extends StatefulWidget {
  const ExtendingVolumePage({required this.diskVolume, final super.key});

  final DiskVolume diskVolume;

  @override
  State<ExtendingVolumePage> createState() => _ExtendingVolumePageState();
}

class _ExtendingVolumePageState extends State<ExtendingVolumePage> {
  bool _isSizeError = false;
  bool _isPriceError = false;

  double _currentSliderGbValue = 20.0;
  double _euroPerGb = 1.0;

  final double maxGb = 500.0;
  double minGb = 0.0;

  final TextEditingController _sizeController = TextEditingController();
  late final TextEditingController _priceController;

  void _updateByPrice() {
    final double price = double.parse(_priceController.text);
    _currentSliderGbValue = price / _euroPerGb;
    _sizeController.text = _currentSliderGbValue.round.toString();

    /// Now we need to convert size back to price to round
    /// it properly and display it in text field as well,
    /// because size in GB can ONLY(!) be discrete.
    _updateBySize();
  }

  void _updateBySize() {
    final double size = double.parse(_sizeController.text);
    _priceController.text = (size * _euroPerGb).toString();
    _updateErrorStatuses();
  }

  void _updateErrorStatuses() {
    final bool error = minGb > _currentSliderGbValue;
    _isSizeError = error;
    _isPriceError = error;
  }

  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future: context.read<ApiVolumesCubit>().getPricePerGb(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<void> snapshot,
        ) {
          _euroPerGb = snapshot.data as double;
          _sizeController.text = _currentSliderGbValue.toString();
          _priceController.text =
              (_euroPerGb * double.parse(_sizeController.text)).toString();
          _sizeController.addListener(_updateBySize);
          _priceController.addListener(_updateByPrice);
          minGb = widget.diskVolume.gbTotal + 1 < maxGb
              ? widget.diskVolume.gbTotal + 1
              : maxGb;

          return BrandHeroScreen(
            hasBackButton: true,
            heroTitle: 'providers.storage.extending_volume_title'.tr(),
            heroSubtitle: 'providers.storage.extending_volume_description'.tr(),
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  TextField(
                    textInputAction: TextInputAction.next,
                    enabled: true,
                    controller: _sizeController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: _isSizeError ? ' ' : null,
                      labelText: 'providers.storage.size'.tr(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ], // Only numbers can be entered
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    textInputAction: TextInputAction.next,
                    enabled: true,
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: _isPriceError ? ' ' : null,
                      labelText: 'providers.storage.euro'.tr(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ], // Only numbers can be entered
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Slider(
                min: minGb,
                value: widget.diskVolume.gbTotal + 5 < maxGb
                    ? widget.diskVolume.gbTotal + 5
                    : maxGb,
                max: maxGb,
                divisions: 1,
                label: _currentSliderGbValue.round().toString(),
                onChanged: (final double value) {
                  setState(() {
                    _currentSliderGbValue = value;
                    _updateErrorStatuses();
                  });
                },
              ),
              const SizedBox(height: 16),
              FilledButton(
                title: 'providers.extend_volume_button.title'.tr(),
                onPressed: null,
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 1.0,
              ),
              const SizedBox(height: 16),
              const Icon(Icons.info_outlined, size: 24),
              const SizedBox(height: 16),
              Text('providers.storage.extending_volume_price_info'.tr()),
              const SizedBox(height: 16),
            ],
          );
        },
      );
}
