import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

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
  ServerType? serverType;

  void setServerProviderLocation(final ServerProviderLocation location) {
    setState(() {
      serverProviderLocation = location;
    });
  }

  @override
  Widget build(final BuildContext context) {
    if (serverProviderLocation == null) {
      return SelectLocationPage(
        serverInstallationCubit: widget.serverInstallationCubit,
        callback: setServerProviderLocation,
      );
    }

    return SelectTypePage(
      location: serverProviderLocation!,
      serverInstallationCubit: widget.serverInstallationCubit,
    );
  }
}

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({
    required this.serverInstallationCubit,
    required this.callback,
    super.key,
  });

  final Function callback;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future: serverInstallationCubit.fetchAvailableLocations(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Object?> snapshot,
        ) {
          if (snapshot.hasData) {
            if ((snapshot.data as List<ServerProviderLocation>).isEmpty) {
              return Text('initializing.no_locations_found'.tr());
            }
            return ListView(
              padding: paddingH15V0,
              children: [
                ...(snapshot.data! as List<ServerProviderLocation>).map(
                  (final location) => InkWell(
                    onTap: () {
                      callback(location);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (location.flag != null) Text(location.flag!),
                            const SizedBox(height: 8),
                            Text(location.title),
                            const SizedBox(height: 8),
                            if (location.description != null)
                              Text(location.description!),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}

class SelectTypePage extends StatelessWidget {
  const SelectTypePage({
    required this.location,
    required this.serverInstallationCubit,
    super.key,
  });

  final ServerProviderLocation location;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future: serverInstallationCubit.fetchAvailableTypesByLocation(location),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Object?> snapshot,
        ) {
          if (snapshot.hasData) {
            if ((snapshot.data as List<ServerType>).isEmpty) {
              return Text('initializing.no_server_types_found'.tr());
            }
            return ListView(
              padding: paddingH15V0,
              children: [
                ...(snapshot.data! as List<ServerType>).map(
                  (final type) => InkWell(
                    onTap: () {
                      serverInstallationCubit.setServerType(type);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              type.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'cores: ${type.cores.toString()}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'ram: ${type.ram.toString()}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'disk: ${type.disk.gibibyte.toString()}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'price: ${type.price.value.toString()} ${type.price.currency}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
