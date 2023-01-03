import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_button/outlined_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/outlined_card.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
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
  DnsProvider selectedProvider = DnsProvider.unknown;

  void setProvider(final DnsProvider provider) {
    setState(() {
      selectedProvider = provider;
    });
  }

  @override
  Widget build(final BuildContext context) {
    switch (selectedProvider) {
      case DnsProvider.unknown:
        return ProviderSelectionPage(
          serverInstallationCubit: widget.serverInstallationCubit,
          callback: setProvider,
        );

      case DnsProvider.cloudflare:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: DnsProvider.cloudflare,
            pathToHow: 'how_cloudflare',
            image: Image.asset(
              'assets/images/logos/cloudflare.png',
              width: 150,
            ),
          ),
        );

      case DnsProvider.digitalOcean:
        return ProviderInputDataPage(
          providerCubit: widget.formCubit,
          providerInfo: ProviderPageInfo(
            providerType: DnsProvider.digitalOcean,
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
  final DnsProvider providerType;
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
          providerInfo.image,
          const SizedBox(height: 10),
          Text(
            'initializing.connect_to_dns'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          CubitFormTextField(
            formFieldCubit: providerCubit.apiKey,
            textAlign: TextAlign.center,
            scrollPadding: const EdgeInsets.only(bottom: 70),
            decoration: const InputDecoration(
              hintText: 'Provider API Token',
            ),
          ),
          const Spacer(),
          FilledButton(
            title: 'basis.connect'.tr(),
            onPressed: () => providerCubit.trySubmit(),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
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
                            .setDnsProviderType(DnsProvider.cloudflare);
                        callback(DnsProvider.cloudflare);
                      },
                    ),
                    // Outlined button that will open website
                    BrandOutlinedButton(
                      onPressed: () =>
                          launchURL('https://cloud.digitalocean.com/'),
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
                            .setDnsProviderType(DnsProvider.digitalOcean);
                        callback(DnsProvider.digitalOcean);
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
