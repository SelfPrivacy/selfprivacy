import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoveryConfirmServer extends StatefulWidget {
  const RecoveryConfirmServer({
    this.server,
    this.serverProviderCredential,
    this.submitCallback,
    super.key,
  });

  final Server? server;
  final ServerProviderCredential? serverProviderCredential;
  final Function()? submitCallback;

  @override
  State<RecoveryConfirmServer> createState() => _RecoveryConfirmServerState();
}

class _RecoveryConfirmServerState extends State<RecoveryConfirmServer> {
  bool _isExtended = false;

  bool _isServerFound(final List<ServerBasicInfoWithValidators> servers) =>
      servers
          .where((final server) => server.isIpValid && server.isReverseDnsValid)
          .length ==
      1;

  ServerBasicInfoWithValidators _firstValidServer(
    final List<ServerBasicInfoWithValidators> servers,
  ) =>
      servers
          .where((final server) => server.isIpValid && server.isReverseDnsValid)
          .first;

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle:
        _isExtended
            ? 'recovering.choose_server'.tr()
            : 'recovering.confirm_server'.tr(),
    heroSubtitle:
        _isExtended
            ? 'recovering.choose_server_description'.tr()
            : 'recovering.confirm_server_description'.tr(),
    hasBackButton: true,
    ignoreBreakpoints: true,
    onBackButtonPressed: () {
      Navigator.of(context).popUntil((final route) => route.isFirst);
    },
    hasFlashButton: false,
    children: [
      FutureBuilder<List<ServerBasicInfoWithValidators>>(
        future: context.read<ServerInstallationCubit>().getAvailableServers(
          server: widget.server,
        ),
        builder: (final context, final snapshot) {
          if (snapshot.hasData) {
            final servers = snapshot.data;
            return Column(
              children: [
                if (servers != null && servers.isNotEmpty)
                  Column(
                    children: [
                      if (!_isExtended && _isServerFound(servers))
                        confirmServer(
                          context: context,
                          server: _firstValidServer(servers),
                          showMoreServersButton: servers.length > 1,
                        ),
                      if (_isExtended || !_isServerFound(servers))
                        chooseServer(context, servers),
                    ],
                  ),
                if (servers?.isEmpty ?? true)
                  Center(
                    child: Text(
                      'recovering.no_servers'.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    ],
  );

  Widget confirmServer({
    required final BuildContext context,
    required final ServerBasicInfoWithValidators server,
    required final bool showMoreServersButton,
  }) => Column(
    children: [
      serverCard(context: context, server: server),
      const SizedBox(height: 16),
      BrandButton.filled(
        child: Text('recovering.confirm_server_accept'.tr()),
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

  Widget chooseServer(
    final BuildContext context,
    final List<ServerBasicInfoWithValidators> servers,
  ) => Column(
    children: [
      for (final server in servers)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: serverCard(
            context: context,
            server: server,
            onTap: () => _showConfirmationDialog(context, server),
          ),
        ),
    ],
  );

  Widget serverCard({
    required final BuildContext context,
    required final ServerBasicInfoWithValidators server,
    final VoidCallback? onTap,
  }) => FilledCard(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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

  Future _showConfirmationDialog(
    final BuildContext context,
    final ServerBasicInfoWithValidators server,
  ) => showDialog(
    context: context,
    builder:
        (final context) => AlertDialog(
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
              Text(
                'recovering.modal_confirmation_description'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
                textIfInvalid: 'recovering.modal_confirmation_dns_invalid'.tr(),
              ),
              const SizedBox(height: 8),
              IsValidStringDisplay(
                isValid: server.isIpValid,
                textIfValid: 'recovering.modal_confirmation_ip_valid'.tr(),
                textIfInvalid: 'recovering.modal_confirmation_ip_invalid'.tr(),
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
                if (widget.server != null &&
                    widget.serverProviderCredential != null) {
                  context.read<TokensBloc>().add(
                    ServerSelectedForProviderToken(
                      server,
                      widget.server!,
                      widget.serverProviderCredential!,
                    ),
                  );
                  Navigator.of(context).pop();
                  widget.submitCallback?.call();
                } else {
                  unawaited(
                    context.read<ServerInstallationCubit>().setServerId(server),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
  );
}

class IsValidStringDisplay extends StatelessWidget {
  const IsValidStringDisplay({
    required this.isValid,
    required this.textIfValid,
    required this.textIfInvalid,
    super.key,
  });

  final bool isValid;
  final String textIfValid;
  final String textIfInvalid;

  @override
  Widget build(final BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (isValid)
        Icon(Icons.check, color: Theme.of(context).colorScheme.onSurface)
      else
        Icon(Icons.close, color: Theme.of(context).colorScheme.error),
      const SizedBox(width: 8),
      Expanded(
        child:
            isValid
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
                ),
      ),
    ],
  );
}
