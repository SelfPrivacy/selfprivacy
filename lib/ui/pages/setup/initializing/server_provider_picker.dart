import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/provider_form_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_button/outlined_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/outlined_card.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/utils/launch_url.dart';

class ServerProviderPicker extends StatefulWidget {
  const ServerProviderPicker({
    required this.formCubit,
    required this.serverInstallationCubit,
    super.key,
  });

  final ProviderFormCubit formCubit;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  State<ServerProviderPicker> createState() => _ServerProviderPickerState();
}

class _ServerProviderPickerState extends State<ServerProviderPicker> {
  ServerProvider selectedProvider = ServerProvider.unknown;

  void setProvider(final ServerProvider provider) {
    setState(() {
      selectedProvider = provider;
    });
  }

  @override
  Widget build(final BuildContext context) {
    switch (selectedProvider) {
      case ServerProvider.unknown:
        return ProviderSelectionPage(
          serverInstallationCubit: widget.serverInstallationCubit,
          callback: setProvider,
        );

      case ServerProvider.hetzner:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: ServerProvider.hetzner,
            pathToHow: 'how_hetzner',
            image: Image.asset(
              'assets/images/logos/hetzner.png',
              width: 150,
            ),
          ),
        );

      case ServerProvider.digitalOcean:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: ServerProvider.digitalOcean,
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
  final ServerProvider providerType;
}

class ProviderInputDataPage extends StatelessWidget {
  const ProviderInputDataPage({
    required this.providerInfo,
    required this.providerCubit,
    super.key,
  });

  final ProviderPageInfo providerInfo;
  final ProviderFormCubit providerCubit;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${'initializing.connect_to_server_provider'.tr()}${providerInfo.providerType.displayName}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            'initializing.connect_to_server_provider_text'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          CubitFormTextField(
            formFieldCubit: providerCubit.apiKey,
            textAlign: TextAlign.center,
            scrollPadding: const EdgeInsets.only(bottom: 70),
            decoration: const InputDecoration(
              hintText: 'Provider API Token',
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            title: 'basis.connect'.tr(),
            onPressed: () => providerCubit.trySubmit(),
          ),
          const SizedBox(height: 10),
          BrandOutlinedButton(
            child: Text('initializing.how'.tr()),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (final BuildContext context) => BrandBottomSheet(
                isExpended: true,
                child: Padding(
                  padding: paddingH15V0,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      BrandMarkdown(
                        fileName: providerInfo.pathToHow,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class ProviderSelectionPage extends StatelessWidget {
  const ProviderSelectionPage({
    required this.callback,
    required this.serverInstallationCubit,
    super.key,
  });

  final Function callback;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => SizedBox(
        width: double.infinity,
        child: Column(
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
            const SizedBox(height: 10),
            OutlinedCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                      'initializing.select_provider_countries_text_hetzner'
                          .tr(),
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
                    FilledButton(
                      title: 'basis.select'.tr(),
                      onPressed: () {
                        serverInstallationCubit
                            .setServerProviderType(ServerProvider.hetzner);
                        callback(ServerProvider.hetzner);
                      },
                    ),
                    // Outlined button that will open website
                    BrandOutlinedButton(
                      onPressed: () =>
                          launchURL('https://www.hetzner.com/cloud'),
                      title: 'initializing.select_provider_site_button'.tr(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    FilledButton(
                      title: 'basis.select'.tr(),
                      onPressed: () {
                        serverInstallationCubit
                            .setServerProviderType(ServerProvider.digitalOcean);
                        callback(ServerProvider.digitalOcean);
                      },
                    ),
                    // Outlined button that will open website
                    BrandOutlinedButton(
                      onPressed: () =>
                          launchURL('https://www.digitalocean.com'),
                      title: 'initializing.select_provider_site_button'.tr(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InfoBox(text: 'initializing.select_provider_notice'.tr()),
          ],
        ),
      );
}
