import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

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
            pathToHow: 'how_cloudflare',
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
  Widget build(final BuildContext context) => Column(
        children: [
          Text(
            'initializing.select_provider'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'initializing.dns_provider_description'.tr(),
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
                    serverInstallationCubit
                        .setDnsProviderType(DnsProvider.cloudflare);
                    callback(DnsProvider.cloudflare);
                  },
                  child: Image.asset(
                    'assets/images/logos/cloudflare.png',
                    width: 150,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    serverInstallationCubit
                        .setDnsProviderType(DnsProvider.digitalOcean);
                    callback(DnsProvider.digitalOcean);
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
