import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/illustrations/stray_deer.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

class ServerTypePicker extends StatefulWidget {
  const ServerTypePicker({required this.serverInstallationCubit, super.key});

  final ServerInstallationCubit serverInstallationCubit;

  @override
  State<ServerTypePicker> createState() => _ServerTypePickerState();
}

class _ServerTypePickerState extends State<ServerTypePicker> {
  ServerProviderLocation? serverProviderLocation;
  ServerType? serverType;

  Future<void> setServerProviderLocation(
    final ServerProviderLocation? location,
  ) async {
    if (location != null) {
      await widget.serverInstallationCubit.setLocationIdentifier(
        location.identifier,
      );
    }
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
      backToLocationPickingCallback: () async {
        await setServerProviderLocation(null);
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

  final Function(ServerProviderLocation) callback;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => FutureBuilder(
    future: serverInstallationCubit.fetchAvailableLocations(),
    builder: (
      final BuildContext context,
      final AsyncSnapshot<Object?> snapshot,
    ) {
      if (snapshot.hasData) {
        if ((snapshot.data! as List<ServerProviderLocation>).isEmpty) {
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
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${location.flag} ${location.title}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  location.countryDisplayKey.tr(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                if (location.description != null)
                                  const SizedBox(height: 4),
                                if (location.description != null)
                                  Text(
                                    location.description!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
        return const Center(child: CircularProgressIndicator.adaptive());
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
  final VoidCallback backToLocationPickingCallback;

  @override
  Widget build(final BuildContext context) {
    final Future<List<ServerType>> serverTypes = serverInstallationCubit
        .fetchAvailableTypesByLocation(location);
    final Future<AdditionalPricing?> prices = serverInstallationCubit
        .fetchAvailableAdditionalPricing(location);
    return FutureBuilder(
      future: Future.wait([serverTypes, prices]),
      builder: (
        final BuildContext context,
        final AsyncSnapshot<List<dynamic>> snapshot,
      ) {
        if (snapshot.hasData) {
          if ((snapshot.data![0] as List<ServerType>).isEmpty ||
              (snapshot.data![1] as AdditionalPricing?) == null) {
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
                  builder:
                      (final context, final constraints) => CustomPaint(
                        size: Size(
                          constraints.maxWidth,
                          constraints.maxWidth * 1,
                        ),
                        painter: StrayDeerPainter(
                          colorScheme: Theme.of(context).colorScheme,
                          colorPalette:
                              InheritedAppController.of(context).corePalette,
                        ),
                      ),
                ),
                const SizedBox(height: 16),
                BrandButton.filled(
                  onPressed: backToLocationPickingCallback,
                  title: 'initializing.back_to_locations'.tr(),
                ),
              ],
            );
          }
          final prices = snapshot.data![1] as AdditionalPricing;
          final storagePrice =
              serverInstallationCubit.initialStorage.gibibyte *
              prices.perVolumeGb.value;
          final publicIpPrice = prices.perPublicIpv4.value;
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
                ...(snapshot.data![0] as List<ServerType>).map(
                  (final type) => Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () async {
                              await serverInstallationCubit.setServerType(type);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    type.title,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.memory_outlined,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'server.core_count'.plural(type.cores),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.memory_outlined,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'initializing.choose_server_type_ram'
                                            .tr(args: [type.ram.toString()]),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.sd_card_outlined,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'initializing.choose_server_type_storage'
                                            .tr(
                                              args: [
                                                type.disk.gibibyte.toString(),
                                              ],
                                            ),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
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
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'initializing.choose_server_type_payment_per_month'.tr(
                                          args: [
                                            '${UiHelpers.formatWithPrecision(type.price.value + storagePrice + publicIpPrice)} ${type.price.currency.shortcode}',
                                          ],
                                        ),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        VerticalDivider(
                                          width: 24,
                                          indent: 4,
                                          endIndent: 4,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(128),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.memory_outlined,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withAlpha(128),
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'initializing.choose_server_type_payment_server'.tr(
                                                    args: [
                                                      UiHelpers.formatWithPrecision(
                                                        type.price.value,
                                                      ),
                                                    ],
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withAlpha(128),
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.sd_card_outlined,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withAlpha(128),
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'initializing.choose_server_type_payment_storage'.tr(
                                                    args: [
                                                      UiHelpers.formatWithPrecision(
                                                        storagePrice,
                                                      ),
                                                    ],
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withAlpha(128),
                                                      ),
                                                ),
                                              ],
                                            ),
                                            if (publicIpPrice != 0)
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.lan_outlined,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withAlpha(128),
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'initializing.choose_server_type_payment_ip'.tr(
                                                      args: [
                                                        UiHelpers.formatWithPrecision(
                                                          publicIpPrice,
                                                        ),
                                                      ],
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: Theme.of(
                                                                context,
                                                              )
                                                              .colorScheme
                                                              .onSurface
                                                              .withAlpha(128),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
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
            secondaryColumn: InfoBox(
              text: 'initializing.choose_server_type_notice'.tr(),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
