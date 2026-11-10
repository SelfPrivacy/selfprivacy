import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/ui/atoms/not_applied_label.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/timezone_selection_tile.dart';
import 'package:selfprivacy/ui/organisms/server_settings_view.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timezone/timezone.dart';

part 'select_timezone.dart';

@RoutePage()
class ServerSettingsPage extends StatelessWidget {
  const ServerSettingsPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bloc = context.read<ServerSettingsBloc>();
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
          hasFlashButton: true,
          heroIcon: Icons.settings_outlined,
          heroTitle: 'server.settings'.tr(),
          children: [
            ServerSettingsView(
              state: context.watch<ServerSettingsBloc>().state,
              onEvent: bloc.add,
              onRefresh: () => unawaited(bloc.refresh()),
              onChannel: () => unawaited(
                context.pushRoute(const SelectUpdateChannelRoute()),
              ),
              onTimezone: () =>
                  unawaited(context.pushRoute(const SelectTimezoneRoute())),
              onCredentialPolicy: () =>
                  unawaited(context.pushRoute(const CredentialPolicyRoute())),
              onShowOperation: () =>
                  unawaited(showModalJobsSheet(context: context)),
            ),
          ],
        ),
      ),
    );
  }
}
