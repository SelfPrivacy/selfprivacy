import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/server_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/atoms/cards/outlined_card.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/utils/launch_url.dart';

class ServerProviderPicker extends StatefulWidget {
  const ServerProviderPicker({
    required this.formCubit,
    required this.serverInstallationCubit,
    super.key,
  });

  final ServerProviderFormCubit formCubit;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  State<ServerProviderPicker> createState() => _ServerProviderPickerState();
}

class _ServerProviderPickerState extends State<ServerProviderPicker> {
  ServerProviderType selectedProvider = ServerProviderType.unknown;

  void setProvider(final ServerProviderType provider) {
    setState(() {
      selectedProvider = provider;
    });
  }

  @override
  Widget build(final BuildContext context) {
    switch (selectedProvider) {
      case ServerProviderType.unknown:
        return ProviderSelectionPage(
          serverInstallationCubit: widget.serverInstallationCubit,
          callback: setProvider,
        );

      case ServerProviderType.hetzner:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: ServerProviderType.hetzner,
            pathToHow: 'how_hetzner',
            image: Image.asset('assets/images/logos/hetzner.png', width: 150),
          ),
        );

      case ServerProviderType.digitalOcean:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: ServerProviderType.digitalOcean,
            pathToHow: 'how_digital_ocean',
            image: Image.asset(
              'assets/images/logos/digital_ocean.png',
              width: 150,
            ),
          ),
        );
    }
  }
}

class ProviderPageInfo {
  const ProviderPageInfo({
    required this.providerType,
    required this.pathToHow,
    required this.image,
  });

  final String pathToHow;
  final Image image;
  final ServerProviderType providerType;
}

class ProviderInputDataPage extends StatelessWidget {
  const ProviderInputDataPage({
    required this.providerInfo,
    required this.providerCubit,
    super.key,
  });

  final ProviderPageInfo providerInfo;
  final ServerProviderFormCubit providerCubit;

  @override
  Widget build(final BuildContext context) => ResponsiveLayoutWithInfobox(
    topChild: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'initializing.connect_to_server_provider'.tr(
            namedArgs: {'provider': providerInfo.providerType.displayName},
          ),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'initializing.connect_to_server_provider_text'.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
    primaryColumn: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CubitFormTextField(
          autofocus: true,
          formFieldCubit: providerCubit.apiKey,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Provider API Token',
          ),
        ),
        const SizedBox(height: 32),
        BrandButton.filled(
          child: Text('basis.connect'.tr()),
          onPressed: providerCubit.trySubmit,
        ),
        const SizedBox(height: 10),
        BrandOutlinedButton(
          child: Text('initializing.how'.tr()),
          onPressed: () {
            context.read<SupportSystemCubit>().showArticle(
              article: providerInfo.pathToHow,
              context: context,
            );
          },
        ),
      ],
    ),
  );
}

class ProviderSelectionPage extends StatelessWidget {
  const ProviderSelectionPage({
    required this.callback,
    required this.serverInstallationCubit,
    super.key,
  });

  final Function(ServerProviderType) callback;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: double.infinity,
    child: ResponsiveLayoutWithInfobox(
      topChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'initializing.connect_to_server'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            'initializing.select_provider'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      primaryColumn: Column(
        children: [
          OutlinedCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xFFD50C2D),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/logos/hetzner.svg',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Hetzner Cloud',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_countries_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'initializing.select_provider_countries_text_hetzner'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_price_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'initializing.select_provider_price_text_hetzner'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_payment_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'initializing.select_provider_payment_text_hetzner'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_email_notice'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  BrandButton.filled(
                    child: Text('basis.select'.tr()),
                    onPressed: () async {
                      await serverInstallationCubit.setServerProviderType(
                        ServerProviderType.hetzner,
                      );
                      callback(ServerProviderType.hetzner);
                    },
                  ),
                  // Outlined button that will open website
                  BrandOutlinedButton(
                    onPressed: () => launchURL('https://www.hetzner.com/cloud'),
                    title: 'initializing.select_provider_site_button'.tr(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xFF0080FF),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/logos/digital_ocean.svg',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Digital Ocean',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_countries_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'initializing.select_provider_countries_text_do'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_price_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'initializing.select_provider_price_text_do'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.select_provider_payment_title'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'initializing.select_provider_payment_text_do'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.server_provider_email_unavailable'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  BrandButton.filled(
                    child: Text('basis.select'.tr()),
                    onPressed: () async {
                      await serverInstallationCubit.setServerProviderType(
                        ServerProviderType.digitalOcean,
                      );
                      callback(ServerProviderType.digitalOcean);
                    },
                  ),
                  // Outlined button that will open website
                  BrandOutlinedButton(
                    onPressed: () => launchURL('https://www.digitalocean.com'),
                    title: 'initializing.select_provider_site_button'.tr(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      secondaryColumn: InfoBox(
        text: 'initializing.select_provider_notice'.tr(),
      ),
    ),
  );
}
