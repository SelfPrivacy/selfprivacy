import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';

class ServerTypePicker extends StatefulWidget {
  const ServerTypePicker({
    required this.serverInstallationCubit,
    super.key,
  });

  final ServerInstallationCubit serverInstallationCubit;

  @override
  State<ServerTypePicker> createState() => _ServerTypePickerState();
}

class _ServerTypePickerState extends State<ServerTypePicker> {
  ServerProviderLocation? serverProviderLocation;

  void setServerProviderLocation(final ServerProviderLocation location) {
    setState(() {
      serverProviderLocation = location;
    });
  }

  @override
  Widget build(final BuildContext context) {
    
  }
}

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({
    required this.serverInstallationCubit,
    super.key,
  });

  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => FutureBuilder(
            future: serverInstallationCubit.repository.serverProviderApiFactory,
            builder: (
              final BuildContext context,
              final AsyncSnapshot<Object?> snapshot,
            ) {
              if (snapshot.hasData) {
                return _KeyDisplay(
                  newDeviceKey: snapshot.data.toString(),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
}

class ProviderSelectionPage extends StatelessWidget {
  const ProviderSelectionPage({
    required this.callback,
    super.key,
  });

  final Function callback;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          Text(
            'initializing.select_provider'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'initializing.place_where_data'.tr(),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 320,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<ServerInstallationCubit>()
                        .setServerProviderType(ServerProvider.hetzner);
                    callback(ServerProvider.hetzner);
                  },
                  child: Image.asset(
                    'assets/images/logos/hetzner.png',
                    width: 150,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<ServerInstallationCubit>()
                        .setServerProviderType(ServerProvider.digitalOcean);
                    callback(ServerProvider.digitalOcean);
                  },
                  child: Image.asset(
                    'assets/images/logos/digital_ocean.png',
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
