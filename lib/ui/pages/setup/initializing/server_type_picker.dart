import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/illustrations/stray_deer.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';

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

  void setServerProviderLocation(final ServerProviderLocation? location) {
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
      backToLocationPickingCallback: () {
        setServerProviderLocation(null);
      },
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
            return ResponsiveLayoutWithInfobox(
              topChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'initializing.choose_location_type'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.choose_location_type_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              primaryColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(snapshot.data! as List<ServerProviderLocation>).map(
                    (final location) => Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: InkResponse(
                              highlightShape: BoxShape.rectangle,
                              onTap: () {
                                callback(location);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${location.flag ?? ''} ${location.title}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    if (location.description != null)
                                      Text(
                                        location.description!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}

class SelectTypePage extends StatelessWidget {
  const SelectTypePage({
    required this.backToLocationPickingCallback,
    required this.location,
    required this.serverInstallationCubit,
    super.key,
  });

  final ServerProviderLocation location;
  final ServerInstallationCubit serverInstallationCubit;
  final Function backToLocationPickingCallback;

  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future: serverInstallationCubit.fetchAvailableTypesByLocation(location),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Object?> snapshot,
        ) {
          if (snapshot.hasData) {
            if ((snapshot.data as List<ServerType>).isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'initializing.locations_not_found'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.locations_not_found_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  LayoutBuilder(
                    builder: (final context, final constraints) => CustomPaint(
                      size: Size(
                        constraints.maxWidth,
                        (constraints.maxWidth * 1).toDouble(),
                      ),
                      painter: StrayDeerPainter(
                        colorScheme: Theme.of(context).colorScheme,
                        colorPalette: context
                            .read<AppSettingsCubit>()
                            .state
                            .corePaletteOrDefault,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BrandButton.rised(
                    onPressed: () {
                      backToLocationPickingCallback();
                    },
                    text: 'initializing.back_to_locations'.tr(),
                  ),
                ],
              );
            }
            return ResponsiveLayoutWithInfobox(
              topChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'initializing.choose_server_type'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.choose_server_type_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              primaryColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(snapshot.data! as List<ServerType>).map(
                    (final type) => Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.memory_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'server.core_count'
                                              .plural(type.cores),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.memory_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'initializing.choose_server_type_ram'
                                              .tr(args: [type.ram.toString()]),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.sd_card_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'initializing.choose_server_type_storage'
                                              .tr(
                                            args: [
                                              type.disk.gibibyte.toString()
                                            ],
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(height: 8),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.payments_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'initializing.choose_server_type_payment_per_month'
                                              .tr(
                                            args: [
                                              '${type.price.value.toString()} ${type.price.currency.shortcode}'
                                            ],
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
              secondaryColumn:
                  InfoBox(text: 'initializing.choose_server_type_notice'.tr()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
