import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/organisms/credential_policy_selection.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

@RoutePage()
class CredentialPolicyPage extends StatefulWidget {
  const CredentialPolicyPage({super.key});

  @override
  State<CredentialPolicyPage> createState() => _CredentialPolicyPageState();
}

class _CredentialPolicyPageState extends State<CredentialPolicyPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<ServerSettingsBloc>().refresh());
  }

  @override
  Widget build(final BuildContext context) {
    final bloc = context.watch<ServerSettingsBloc>();
    final state = bloc.state;
    final scrollBehavior = ScrollConfiguration.of(context);
    return RefreshIndicator(
      onRefresh: bloc.refresh,
      child: ScrollConfiguration(
        behavior: scrollBehavior.copyWith(
          physics: AlwaysScrollableScrollPhysics(
            parent: scrollBehavior.getScrollPhysics(context),
          ),
        ),
        child: BrandHeroScreen(
          heroIcon: Icons.security_outlined,
          heroTitle: 'server.credential_policy.title'.tr(),
          children: [
            CredentialPolicySelection(
              snapshot: state.policy,
              pendingPolicy: state.pending<ChangeCredentialPolicyJob>()?.policy,
              enabled: state.canEditPolicy,
              applying: state is ServerSettingsApplying,
              onRefresh: () => unawaited(bloc.refresh()),
              onShowOperation: () =>
                  unawaited(showModalJobsSheet(context: context)),
              onAdd: (final policy) {
                bloc.add(CredentialPolicySelected(policy));
                unawaited(context.router.maybePop());
              },
            ),
          ],
        ),
      ),
    );
  }
}
