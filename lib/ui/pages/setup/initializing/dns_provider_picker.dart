import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/atoms/cards/outlined_card.dart';
import 'package:sp_cubit_form/sp_cubit_form.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DnsProviderPicker extends StatefulWidget {
  const DnsProviderPicker({required this.serverInstallationCubit, super.key});

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
          providerInfo: const ProviderPageInfo(
            providerType: DnsProviderType.cloudflare,
            pathToHow: 'how_cloudflare',
          ),
          serverInstallationCubit: widget.serverInstallationCubit,
        );

      case DnsProviderType.digitalOcean:
        return ProviderInputDataPage(
          providerInfo: const ProviderPageInfo(
            providerType: DnsProviderType.digitalOcean,
            pathToHow: 'how_digital_ocean',
          ),
          serverInstallationCubit: widget.serverInstallationCubit,
        );

      case DnsProviderType.desec:
        return ProviderInputDataPage(
          providerInfo: const ProviderPageInfo(
            providerType: DnsProviderType.desec,
            pathToHow: 'how_desec',
          ),
          serverInstallationCubit: widget.serverInstallationCubit,
        );

      case DnsProviderType.porkbun:
        return ProviderInputDataPage(
          providerInfo: const ProviderPageInfo(
            providerType: DnsProviderType.porkbun,
            pathToHow: 'how_porkbun',
          ),
          serverInstallationCubit: widget.serverInstallationCubit,
        );
    }
  }
}

class ProviderPageInfo {
  const ProviderPageInfo({required this.providerType, required this.pathToHow});

  final String pathToHow;
  final DnsProviderType providerType;
}

class ProviderInputDataPage extends StatelessWidget {
  const ProviderInputDataPage({
    required this.providerInfo,
    required this.serverInstallationCubit,
    super.key,
  });

  final ProviderPageInfo providerInfo;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => DnsProviderFormCubit(
      serverInstallationCubit,
      providerInfo.providerType,
    ),
    child: Builder(
      builder: (final context) {
        final formCubit = context.watch<DnsProviderFormCubit>();
        return Column(
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
            if (providerInfo
                .providerType
                .requiredCredentials
                .requiresTokenId) ...[
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: formCubit.tokenId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Provider API Token ID',
                ),
              ),
              const SizedBox(height: 16),
            ],
            CubitFormTextField(
              autofocus: true,
              formFieldCubit: formCubit.token,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Provider API Token',
              ),
            ),
            if (providerInfo.providerType.requiredCredentials.requiresUrl) ...[
              const SizedBox(height: 16),
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: formCubit.url,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Provider API URL',
                ),
              ),
            ],
            if (providerInfo
                .providerType
                .requiredCredentials
                .requiresTenant) ...[
              const SizedBox(height: 16),
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: formCubit.tenant,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Provider API Tenant',
                ),
              ),
            ],
            if (providerInfo
                .providerType
                .requiredCredentials
                .requiresSecondaryToken) ...[
              const SizedBox(height: 16),
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: formCubit.secondaryToken,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Provider API Secondary Token',
                ),
              ),
            ],
            const SizedBox(height: 32),
            BrandButton.filled(
              title: 'basis.connect'.tr(),
              onPressed: formCubit.trySubmit,
            ),
            const SizedBox(height: 10),
            BrandOutlinedButton(
              child: Text('initializing.how'.tr()),
              onPressed: () => context.read<SupportSystemCubit>().showArticle(
                article: providerInfo.pathToHow,
                context: context,
              ),
            ),
          ],
        );
      },
    ),
  );
}

class ProviderSelectionPage extends StatelessWidget {
  const ProviderSelectionPage({
    required this.callback,
    required this.serverInstallationCubit,
    super.key,
  });

  final Function(DnsProviderType) callback;
  final ServerInstallationCubit serverInstallationCubit;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      // TODO(NaiJi): Remove obvious repetition
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
                        color: const Color.fromARGB(255, 245, 229, 82),
                      ),
                      child: SvgPicture.asset('assets/images/logos/desec.svg'),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'deSEC',
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
                BrandButton.filled(
                  title: 'basis.select'.tr(),
                  onPressed: () async {
                    await serverInstallationCubit.setDnsProviderType(
                      DnsProviderType.desec,
                    );
                    callback(DnsProviderType.desec);
                  },
                ),
                // Outlined button that will open website
                BrandOutlinedButton(
                  onPressed: () => launchUrlString('https://desec.io/'),
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
                        color: const Color.fromARGB(255, 244, 128, 31),
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
                BrandButton.filled(
                  title: 'basis.select'.tr(),
                  onPressed: () async {
                    await serverInstallationCubit.setDnsProviderType(
                      DnsProviderType.cloudflare,
                    );
                    callback(DnsProviderType.cloudflare);
                  },
                ),
                // Outlined button that will open website
                BrandOutlinedButton(
                  onPressed: () =>
                      launchUrlString('https://dash.cloudflare.com/'),
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
                        color: const Color.fromARGB(255, 1, 126, 251),
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
                BrandButton.filled(
                  title: 'basis.select'.tr(),
                  onPressed: () async {
                    await serverInstallationCubit.setDnsProviderType(
                      DnsProviderType.digitalOcean,
                    );
                    callback(DnsProviderType.digitalOcean);
                  },
                ),
                // Outlined button that will open website
                BrandOutlinedButton(
                  onPressed: () =>
                      launchUrlString('https://cloud.digitalocean.com/'),
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
                        color: const Color.fromARGB(255, 242, 119, 119),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/logos/porkbun.svg',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Porkbun',
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
                  'initializing.select_provider_price_text_registrar'.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                BrandButton.filled(
                  title: 'basis.select'.tr(),
                  onPressed: () async {
                    await serverInstallationCubit.setDnsProviderType(
                      DnsProviderType.porkbun,
                    );
                    callback(DnsProviderType.porkbun);
                  },
                ),
                // Outlined button that will open website
                BrandOutlinedButton(
                  onPressed: () => launchUrlString('https://porkbun.com/'),
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
