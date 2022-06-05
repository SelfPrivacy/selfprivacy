import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoveryConfirmServer extends StatefulWidget {
  const RecoveryConfirmServer({super.key});

  @override
  State<RecoveryConfirmServer> createState() => _RecoveryConfirmServerState();
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
                          confirmServer(context, _firstValidServer(servers),
                              servers.length > 1),
                        if (servers.length > 1 &&
                            (_isExtended || !_isServerFound(servers)))
                          chooseServer(context, servers),
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }

  Widget confirmServer(
    BuildContext context,
    ServerBasicInfoWithValidators server,
    bool showMoreServersButton,
  ) {
    return Column(
      children: [
        serverCard(
          context: context,
          server: server,
        ),
        const SizedBox(height: 16),
        FilledButton(
          title: 'recovering.confirm_server_accept'.tr(),
          onPressed: () => _showConfirmationDialog(context, server),
        ),
        const SizedBox(height: 16),
        if (showMoreServersButton)
          BrandButton.text(
            title: 'recovering.confirm_server_decline'.tr(),
            onPressed: () => setState(() => _isExtended = true),
          ),
      ],
    );
  }

  Widget chooseServer(
      BuildContext context, List<ServerBasicInfoWithValidators> servers) {
    return Column(
      children: [
        for (final server in servers)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: serverCard(
              context: context,
              server: server,
              onTap: () => _showConfirmationDialog(context, server),
            ),
          ),
      ],
    );
  }

  Widget serverCard(
      {required BuildContext context,
      required ServerBasicInfoWithValidators server,
      VoidCallback? onTap}) {
    return BrandCards.filled(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        onTap: onTap,
        title: Text(
          server.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        leading: Icon(
          Icons.dns_outlined,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  server.isReverseDnsValid ? Icons.check : Icons.close,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'rDNS: ${server.reverseDns}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  server.isIpValid ? Icons.check : Icons.close,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'IP: ${server.ip}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
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
                const SizedBox(height: 16),
                Text(
                  'recovering.modal_confirmation_title'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('recovering.modal_confirmation_description'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  server.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                IsValidStringDisplay(
                  isValid: server.isReverseDnsValid,
                  textIfValid: 'recovering.modal_confirmation_dns_valid'.tr(),
                  textIfInvalid:
                      'recovering.modal_confirmation_dns_invalid'.tr(),
                ),
                const SizedBox(height: 8),
                IsValidStringDisplay(
                  isValid: server.isIpValid,
                  textIfValid: 'recovering.modal_confirmation_ip_valid'.tr(),
                  textIfInvalid:
                      'recovering.modal_confirmation_ip_invalid'.tr(),
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

class IsValidStringDisplay extends StatelessWidget {
  const IsValidStringDisplay({
    super.key,
    required this.isValid,
    required this.textIfValid,
    required this.textIfInvalid,
  });

  final bool isValid;
  final String textIfValid;
  final String textIfInvalid;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isValid
            ? Icon(Icons.check, color: Theme.of(context).colorScheme.onSurface)
            : Icon(Icons.close, color: Theme.of(context).colorScheme.error),
        const SizedBox(width: 8),
        Expanded(
            child: isValid
                ? Text(
                    textIfValid,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  )
                : Text(
                    textIfInvalid,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  )),
      ],
    );
  }
}
