import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/forms/backblaze_form.dart';
import 'package:selfprivacy/logic/forms/checks/backblaze_credential_check.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/backblaze_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

@RoutePage()
class AddBackupsTokenPage extends StatefulWidget {
  const AddBackupsTokenPage({super.key});

  @override
  State<AddBackupsTokenPage> createState() => _AddBackupsTokenPageState();
}

class _AddBackupsTokenPageState extends State<AddBackupsTokenPage> {
  late final BackblazeForm backblazeForm = BackblazeForm(
    validateCredentials: checkBackblazeCredentials,
    onSubmit: (final credentials) async {
      context.read<TokensBloc>().add(
        AddBackupsProviderCredential(
          BackupsCredential.create(
            keyId: credentials.keyId,
            applicationKey: credentials.applicationKey,
            provider: BackupsProviderType.backblaze,
          ),
        ),
      );
      await context.maybePop();
    },
  );

  @override
  void dispose() {
    backblazeForm.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle: 'initializing.connect_to_server_provider'.tr(
      namedArgs: {'provider': 'Backblaze'},
    ),
    hasBackButton: true,
    ignoreBreakpoints: true,
    hasSupportDrawer: true,
    hasFlashButton: false,
    children: [
      BackblazeFormView(backblazeForm: backblazeForm),
      const Gap(16),
      BrandButton.text(
        onPressed: () {
          context.read<SupportSystemCubit>().showArticle(
            article: 'how_backblaze',
            context: context,
          );
          Scaffold.of(context).openEndDrawer();
        },
        title: 'initializing.how'.tr(),
      ),
    ],
  );
}
