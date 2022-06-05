import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/devices/devices_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

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
          future: context.read<ApiDevicesCubit>().getNewDeviceKey(),
          builder: (final BuildContext context, final AsyncSnapshot<Object?> snapshot) {
            if (snapshot.hasData) {
              return _KeyDisplay(
                newDeviceKey: snapshot.data.toString(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
}

class _KeyDisplay extends StatelessWidget {
  const _KeyDisplay({super.key, required this.newDeviceKey});
  final String newDeviceKey;

  @override
  Widget build(final BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Text(
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
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: 16),
            Text(
              'devices.add_new_device_screen.tip'.tr(),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton(
          child: Text(
            'basis.done'.tr(),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(height: 24),
      ],
    );
}
