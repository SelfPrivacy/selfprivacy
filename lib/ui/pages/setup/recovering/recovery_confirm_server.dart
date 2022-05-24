import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoveryConfirmServer extends StatefulWidget {
  const RecoveryConfirmServer({Key? key}) : super(key: key);

  @override
  _RecoveryConfirmServerState createState() => _RecoveryConfirmServerState();
}

class _RecoveryConfirmServerState extends State<RecoveryConfirmServer> {
  bool _isExtended = false;

  bool _isServerFound(List<ServerBasicInfoWithValidators> servers) {
    return servers
            .where((server) => server.isIpValid && server.isReverseDnsValid)
            .length ==
        1;
  }

  ServerBasicInfoWithValidators _firstValidServer(
      List<ServerBasicInfoWithValidators> servers) {
    return servers
        .where((server) => server.isIpValid && server.isReverseDnsValid)
        .first;
  }

  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      heroTitle: _isExtended
          ? 'recovering.choose_server'.tr()
          : 'recovering.confirm_server'.tr(),
      heroSubtitle: _isExtended
          ? 'recovering.choose_server_description'.tr()
          : 'recovering.confirm_server_description'.tr(),
      hasBackButton: true,
      hasFlashButton: false,
      children: [
        FutureBuilder<List<ServerBasicInfoWithValidators>>(
          future: context
              .read<ServerInstallationCubit>()
              .getServersOnHetznerAccount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final servers = snapshot.data;
              return Column(
                children: [
                  if (servers != null && servers.isNotEmpty)
                    Column(
                      children: [
                        if (servers.length == 1 ||
                            (!_isExtended && _isServerFound(servers)))
                          _ConfirmServer(context, _firstValidServer(servers),
                              servers.length > 1),
                        if (servers.length > 1 &&
                            (_isExtended || !_isServerFound(servers)))
                          _ChooseServer(context, servers),
                      ],
                    ),
                  if (servers?.isEmpty ?? true)
                    Center(
                      child: Text(
                        'recovering.no_servers'.tr(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }

  Widget _ConfirmServer(
    BuildContext context,
    ServerBasicInfoWithValidators server,
    bool showMoreServersButton,
  ) {
    return Container(
      child: Column(
        children: [
          _ServerCard(
            context: context,
            server: server,
          ),
          SizedBox(height: 16),
          FilledButton(
            title: 'recovering.confirm_server_accept'.tr(),
            onPressed: () => _showConfirmationDialog(context, server),
          ),
          SizedBox(height: 16),
          if (showMoreServersButton)
            BrandButton.text(
              title: 'recovering.confirm_server_decline'.tr(),
              onPressed: () => setState(() => _isExtended = true),
            ),
        ],
      ),
    );
  }

  Widget _ChooseServer(
      BuildContext context, List<ServerBasicInfoWithValidators> servers) {
    return Column(
      children: [
        for (final server in servers)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _ServerCard(
              context: context,
              server: server,
              onTap: () => _showConfirmationDialog(context, server),
            ),
          ),
      ],
    );
  }

  Widget _ServerCard(
      {required BuildContext context,
      required ServerBasicInfoWithValidators server,
      VoidCallback? onTap}) {
    return BrandCards.filled(
      child: ListTile(
        onTap: onTap,
        title: Text(server.name),
        leading: Icon(Icons.dns),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(server.isReverseDnsValid ? Icons.check : Icons.close),
                Text('rDNS: ${server.reverseDns}'),
              ],
            ),
            Row(
              children: [
                Icon(server.isIpValid ? Icons.check : Icons.close),
                Text('IP: ${server.ip}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showConfirmationDialog(
          BuildContext context, ServerBasicInfoWithValidators server) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_outlined),
                const SizedBox(height: 8),
                Text(
                  'recovering.modal_confirmation_title'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('recovering.modal_confirmation_description'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium),
                const Divider(),
                Text(
                  server.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(server.isReverseDnsValid ? Icons.check : Icons.close),
                    const SizedBox(width: 8),
                    Text(server.isReverseDnsValid
                        ? 'recovering.modal_confirmation_dns_valid'.tr()
                        : 'recovering.modal_confirmation_dns_invalid'.tr()),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(server.isIpValid ? Icons.check : Icons.close),
                    const SizedBox(width: 8),
                    Text(server.isIpValid
                        ? 'recovering.modal_confirmation_ip_valid'.tr()
                        : 'recovering.modal_confirmation_ip_invalid'.tr()),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('modals.no'.tr()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('modals.yes'.tr()),
                onPressed: () {
                  context.read<ServerInstallationCubit>().setServerId(server);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
