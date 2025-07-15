import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/add_server_provider_to_exsisting_server_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_server.dart';

@RoutePage()
class AddServerProviderTokenPage extends StatefulWidget {
  const AddServerProviderTokenPage({required this.server, super.key});

  final Server server;

  @override
  State<AddServerProviderTokenPage> createState() =>
      _AddServerProviderTokenPageState();
}

class _AddServerProviderTokenPageState
    extends State<AddServerProviderTokenPage> {
  bool isChoosingServer = false;
  ServerProviderCredential? credential;

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    void setServerProviderKey(final String key) {
      final newCredential = ServerProviderCredential(
        token: key,
        provider: widget.server.hostingDetails.provider,
        tokenId: null,
        associatedServerIds: [],
      );
      context.read<TokensBloc>().add(AddServerProviderToken(newCredential));
      setState(() {
        isChoosingServer = true;
        credential = newCredential;
      });
    }

    if (isChoosingServer && credential != null) {
      return RecoveryConfirmServer(
        server: widget.server,
        serverProviderCredential: credential,
        submitCallback: () {
          Navigator.of(context).popUntil((final route) => route.isFirst);
        },
      );
    }

    if (widget.server.hostingDetails.provider == ServerProviderType.unknown) {
      return BrandHeroScreen(
        heroTitle: 'tokens.server_provider_unknown'.tr(),
        heroSubtitle: 'tokens.server_provider_unknown_description'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        ignoreBreakpoints: true,
        onBackButtonPressed: () {
          Navigator.of(context).popUntil((final route) => route.isFirst);
        },
        children: [
          BrandButton.filled(
            title: 'basis.close'.tr(),
            onPressed:
                () => Navigator.of(
                  context,
                ).popUntil((final route) => route.isFirst),
          ),
        ],
      );
    }

    return _TokenProviderInput(
      appConfig: appConfig,
      server: widget.server,
      setServerProviderKey: setServerProviderKey,
    );
  }
}

class _TokenProviderInput extends StatelessWidget {
  const _TokenProviderInput({
    required this.appConfig,
    required this.server,
    required this.setServerProviderKey,
  });

  final ServerInstallationCubit appConfig;
  final Server server;
  final Function(String) setServerProviderKey;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final BuildContext context) =>
            AddServerProviderToExistingServerFormCubit(
              appConfig,
              setServerProviderKey,
            ),
    child: Builder(
      builder:
          (final BuildContext context) => BrandHeroScreen(
            heroTitle: 'recovering.provider_connected'.tr(
              args: [server.hostingDetails.provider.displayName],
            ),
            heroSubtitle: 'recovering.provider_connected_description'.tr(
              args: [server.domain.domainName],
            ),
            hasBackButton: true,
            hasFlashButton: false,
            hasSupportDrawer: true,
            onBackButtonPressed: () {
              Navigator.of(context).popUntil((final route) => route.isFirst);
            },
            children: [
              CubitFormTextField(
                autofocus: true,
                formFieldCubit:
                    context
                        .read<AddServerProviderToExistingServerFormCubit>()
                        .apiKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'recovering.provider_connected_placeholder'.tr(
                    args: [server.hostingDetails.provider.displayName],
                  ),
                ),
              ),
              const Gap(16),
              BrandButton.filled(
                onPressed:
                    () =>
                        context
                            .read<AddServerProviderToExistingServerFormCubit>()
                            .trySubmit(),
                child: Text('basis.continue'.tr()),
              ),
              const Gap(16),
              Builder(
                builder:
                    (final context) => BrandButton.text(
                      title: 'initializing.how'.tr(),
                      onPressed:
                          () => context.read<SupportSystemCubit>().showArticle(
                            article:
                                server.hostingDetails.provider.supportArticle,
                            context: context,
                          ),
                    ),
              ),
            ],
          ),
    ),
  );
}
