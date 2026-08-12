import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/forms/credential_checks/server_provider_credential_check.dart';
import 'package:selfprivacy/logic/forms/server_provider_form.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/server_provider_form_view.dart';
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
  late final ServerProviderForm serverProviderForm;
  bool isChoosingServer = false;
  ServerProviderCredential? credential;

  @override
  void initState() {
    super.initState();
    serverProviderForm = ServerProviderForm(
      validateCredential: (final credential) => checkServerProviderCredential(
        widget.server.hostingDetails.provider,
        credential,
      ),
      onSubmit: _setServerProviderKey,
    );
  }

  Future<void> _setServerProviderKey(final String key) async {
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

  @override
  void dispose() {
    serverProviderForm.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
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
            onPressed: () =>
                Navigator.of(context).popUntil((final route) => route.isFirst),
          ),
        ],
      );
    }

    return _TokenProviderInput(
      serverProviderForm: serverProviderForm,
      server: widget.server,
    );
  }
}

class _TokenProviderInput extends StatelessWidget {
  const _TokenProviderInput({
    required this.serverProviderForm,
    required this.server,
  });

  final ServerProviderForm serverProviderForm;
  final Server server;

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
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
      ServerProviderFormView(
        serverProviderForm: serverProviderForm,
        fieldLabel: 'recovering.provider_connected_placeholder'.tr(
          args: [server.hostingDetails.provider.displayName],
        ),
        submitLabel: 'basis.continue'.tr(),
      ),
      const Gap(16),
      Builder(
        builder: (final context) => BrandButton.text(
          title: 'initializing.how'.tr(),
          onPressed: () => context.read<SupportSystemCubit>().showArticle(
            article: server.hostingDetails.provider.supportArticle,
            context: context,
          ),
        ),
      ),
    ],
  );
}
