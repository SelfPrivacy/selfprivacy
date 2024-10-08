import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class NewDeviceScreen extends StatelessWidget {
  const NewDeviceScreen({super.key});

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        heroTitle: 'devices.add_new_device_screen.header'.tr(),
        heroSubtitle: 'devices.add_new_device_screen.description'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        children: [
          FutureBuilder(
            future: context.read<DevicesBloc>().getNewDeviceKey(),
            builder: (
              final BuildContext context,
              final AsyncSnapshot<Object?> snapshot,
            ) {
              if (snapshot.hasData) {
                return _KeyDisplay(
                  newDeviceKey: snapshot.data.toString(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ],
      );
}

class _KeyDisplay extends StatelessWidget {
  const _KeyDisplay({required this.newDeviceKey});

  final String newDeviceKey;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),
          SelectableText(
            newDeviceKey,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontFamily: 'RobotoMono',
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              Text(
                'devices.add_new_device_screen.tip'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          BrandButton.filled(
            child: Text(
              'basis.done'.tr(),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 24),
        ],
      );
}
