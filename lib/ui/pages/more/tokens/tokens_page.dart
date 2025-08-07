import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';

@RoutePage()
class TokensPage extends StatelessWidget {
  const TokensPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final TokensState state = context.watch<TokensBloc>().state;
    return BrandHeroScreen(
      heroTitle: 'tokens.title'.tr(),
      heroSubtitle: 'tokens.description'.tr(),
      heroIcon: Icons.token_outlined,
      children: [
        FilledCard(
          child: Column(
            children: [
              ListTileOnSurfaceVariant(
                title: 'tokens.server_provider_tokens'.tr(),
              ),
              const Divider(height: 0),
              if (state.serverProviderCredentials.isEmpty)
                ListTileOnSurfaceVariant(
                  title: 'tokens.no_tokens'.tr(),
                  leadingIcon: Icons.warning_amber_outlined,
                ),
              Column(
                children:
                    state.serverProviderCredentials
                        .map(
                          (final serverProviderCredential) =>
                              _ServerProviderListItem(
                                serverProviderCredential:
                                    serverProviderCredential,
                              ),
                        )
                        .toList(),
              ),
              if (state.serversWithoutProviderCredentials.isNotEmpty)
                Column(
                  children: [
                    const Divider(height: 0),
                    Column(
                      children:
                          state.serversWithoutProviderCredentials
                              .map(
                                (final server) => ListTileOnSurfaceVariant(
                                  title: 'tokens.server_without_token'.tr(
                                    namedArgs: {
                                      'server_domain': server.domain.domainName,
                                      'provider':
                                          server
                                              .hostingDetails
                                              .provider
                                              .displayName,
                                    },
                                  ),
                                  subtitle: 'tokens.tap_to_add_token'.tr(),
                                  leadingIcon: Icons.add_circle_outline,
                                  onTap:
                                      () => context.router.push(
                                        AddServerProviderTokenRoute(
                                          server: server,
                                        ),
                                      ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const Gap(16),
        FilledCard(
          child: Column(
            children: [
              ListTileOnSurfaceVariant(
                title: 'tokens.dns_provider_tokens'.tr(),
              ),
              const Divider(height: 0),
              if (state.dnsProviderCredentials.isEmpty)
                ListTileOnSurfaceVariant(
                  title: 'tokens.no_tokens'.tr(),
                  leadingIcon: Icons.warning_amber_outlined,
                ),
              Column(
                children:
                    state.dnsProviderCredentials
                        .map(
                          (final dnsProviderCredential) => _DnsProviderListItem(
                            dnsProviderCredential: dnsProviderCredential,
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
        const Gap(16),
        FilledCard(
          child: Column(
            children: [
              ListTileOnSurfaceVariant(
                title: 'tokens.backup_provider_tokens'.tr(),
              ),
              const Divider(height: 0),
              if (state.backupsCredentials.isEmpty)
                ListTileOnSurfaceVariant(
                  title: 'tokens.no_tokens'.tr(),
                  leadingIcon: Icons.warning_amber_outlined,
                ),
              Column(
                children:
                    state.backupsCredentials
                        .map(
                          (final backupProviderCredential) =>
                              _BackupProviderListItem(
                                backupProviderCredential:
                                    backupProviderCredential,
                              ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
        const Gap(16),
        ListTile(
          title: Text('tokens.check_again'.tr()),
          onTap:
              (state is TokensInitial)
                  ? null
                  : () =>
                      context.read<TokensBloc>().add(const RevalidateTokens()),
          leading: const Icon(Icons.refresh_outlined),
          enabled: state is! TokensInitial,
        ),
      ],
    );
  }
}

class _ServerProviderListItem extends StatelessWidget {
  const _ServerProviderListItem({required this.serverProviderCredential});

  final TokenStatusWrapper<ServerProviderCredential> serverProviderCredential;

  String getSubtitle(final BuildContext context) {
    String subtitle = '';
    subtitle += serverProviderCredential.status.statusText;
    if (serverProviderCredential.data.associatedServerIds.isNotEmpty) {
      final String serverDomains = serverProviderCredential
          .data
          .associatedServerIds
          .map(
            (final int serverId) =>
                context
                    .read<TokensBloc>()
                    .state
                    .getServerById(serverId)
                    .domain
                    .domainName,
          )
          .join(', ');
      subtitle +=
          '. ${'tokens.used_by'.tr(namedArgs: {'servers': serverDomains})}';
    }
    return subtitle;
  }

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      ListTileOnSurfaceVariant(
        title:
            '${serverProviderCredential.data.provider.displayName} (${serverProviderCredential.data.tokenPrefix}...)',
        subtitle: getSubtitle(context),
        leadingIcon: serverProviderCredential.status.icon,
      ),
    ],
  );
}

class _DnsProviderListItem extends StatelessWidget {
  const _DnsProviderListItem({required this.dnsProviderCredential});

  final TokenStatusWrapper<DnsProviderCredential> dnsProviderCredential;

  String getSubtitle(final BuildContext context) {
    String subtitle = '';
    subtitle += dnsProviderCredential.status.statusText;
    if (dnsProviderCredential.data.associatedDomainNames.isNotEmpty) {
      final String serverDomains = dnsProviderCredential
          .data
          .associatedDomainNames
          .join(', ');
      subtitle +=
          '. ${'tokens.used_by'.tr(namedArgs: {'servers': serverDomains})}';
    }
    return subtitle;
  }

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      ListTileOnSurfaceVariant(
        title:
            '${dnsProviderCredential.data.provider.displayName} (${dnsProviderCredential.data.tokenPrefix}...)',
        subtitle: getSubtitle(context),
        leadingIcon: dnsProviderCredential.status.icon,
      ),
    ],
  );
}

class _BackupProviderListItem extends StatelessWidget {
  const _BackupProviderListItem({required this.backupProviderCredential});

  final TokenStatusWrapper<BackupsCredential> backupProviderCredential;

  String getSubtitle(final BuildContext context) {
    String subtitle = '';
    return subtitle += backupProviderCredential.status.statusText;
  }

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      ListTileOnSurfaceVariant(
        title:
            '${backupProviderCredential.data.provider.name} (${backupProviderCredential.data.tokenPrefix})',
        subtitle: getSubtitle(context),
        leadingIcon: backupProviderCredential.status.icon,
      ),
    ],
  );
}

extension on TokenStatus {
  String get statusText {
    switch (this) {
      case TokenStatus.valid:
        return 'tokens.valid'.tr();
      case TokenStatus.invalid:
        return 'tokens.invalid'.tr();
      case TokenStatus.noAccess:
        return 'tokens.no_access'.tr();
      case TokenStatus.loading:
        return 'tokens.loading'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case TokenStatus.valid:
        return Icons.check_circle_outlined;
      case TokenStatus.invalid:
        return Icons.error_outline_outlined;
      case TokenStatus.noAccess:
        return Icons.no_encryption_outlined;
      case TokenStatus.loading:
        return Icons.sync_outlined;
    }
  }
}

extension on ServerProviderCredential {
  String get tokenPrefix => tokenId ?? token.substring(0, 8);
}

extension on DnsProviderCredential {
  String get tokenPrefix => tokenId ?? token.substring(0, 8);
}

extension on BackupsCredential {
  String get tokenPrefix => keyId;
}
