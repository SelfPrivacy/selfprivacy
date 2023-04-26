import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/components/cards/outlined_card.dart';
import 'package:selfprivacy/utils/network_utils.dart';

class DnsProviderPicker extends StatefulWidget {
  const DnsProviderPicker({
    required this.formCubit,
    required this.serverInstallationCubit,
    super.key,
  });

  final DnsProviderFormCubit formCubit;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  State<DnsProviderPicker> createState() => _DnsProviderPickerState();
}

class _DnsProviderPickerState extends State<DnsProviderPicker> {
  DnsProviderType selectedProvider = DnsProviderType.unknown;

  void setProvider(final DnsProviderType provider) {
    setState(() {
      selectedProvider = provider;
    });
  }

  @override
  Widget build(final BuildContext context) {
    switch (selectedProvider) {
      case DnsProviderType.unknown:
        return ProviderSelectionPage(
          serverInstallationCubit: widget.serverInstallationCubit,
          callback: setProvider,
        );

      case DnsProviderType.cloudflare:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: DnsProviderType.cloudflare,
            pathToHow: 'how_cloudflare',
            image: Image.asset(
              'assets/images/logos/cloudflare.png',
              width: 150,
            ),
          ),
        );

      case DnsProviderType.digitalOcean:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: DnsProviderType.digitalOcean,
            pathToHow: 'how_digital_ocean_dns',
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
  final DnsProviderType providerType;
}

class ProviderInputDataPage extends StatelessWidget {
  const ProviderInputDataPage({
    required this.providerInfo,
    required this.providerCubit,
    super.key,
  });

  final ProviderPageInfo providerInfo;
  final DnsProviderFormCubit providerCubit;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'initializing.connect_to_dns'.tr(),
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
          BrandButton.rised(
            text: 'basis.connect'.tr(),
            onPressed: () => providerCubit.trySubmit(),
          ),
          const SizedBox(height: 10),
          BrandOutlinedButton(
            child: Text('initializing.how'.tr()),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (final BuildContext context) => Padding(
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
              'initializing.select_dns'.tr(),
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
                            color: const Color.fromARGB(255, 241, 215, 166),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/logos/cloudflare.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Cloudflare',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'initializing.select_provider_price_title'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'initializing.select_provider_price_free'.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'initializing.select_provider_payment_title'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'initializing.select_provider_payment_text_cloudflare'
                          .tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    BrandButton.rised(
                      text: 'basis.select'.tr(),
                      onPressed: () {
                        serverInstallationCubit
                            .setDnsProviderType(DnsProviderType.cloudflare);
                        callback(DnsProviderType.cloudflare);
                      },
                    ),
                    // Outlined button that will open website
                    BrandOutlinedButton(
                      onPressed: () =>
                          launchURL('https://dash.cloudflare.com/'),
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
                      'initializing.select_provider_price_title'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'initializing.select_provider_price_free'.tr(),
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
                    BrandButton.rised(
                      text: 'basis.select'.tr(),
                      onPressed: () {
                        serverInstallationCubit
                            .setDnsProviderType(DnsProviderType.digitalOcean);
                        callback(DnsProviderType.digitalOcean);
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
          ],
        ),
      );
}
