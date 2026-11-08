import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/organisms/update_channel_selection.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

@RoutePage()
class SelectUpdateChannelPage extends StatefulWidget {
  const SelectUpdateChannelPage({super.key});

  @override
  State<SelectUpdateChannelPage> createState() =>
      _SelectUpdateChannelPageState();
}

class _SelectUpdateChannelPageState extends State<SelectUpdateChannelPage> {
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
          heroIcon: Icons.system_update_alt,
          heroTitle: 'server.update_channel.title'.tr(),
          children: [
            UpdateChannelSelection(
              snapshot: state.channels,
              onRefresh: () => unawaited(bloc.refresh()),
              pendingChannelId: state
                  .pending<ChangeUpdateChannelJob>()
                  ?.channelId,
              enabled: state.canEditChannels,
              applying: state is ServerSettingsApplying,
              onShowOperation: () =>
                  unawaited(showModalJobsSheet(context: context)),
              onAdd: (final channel) {
                bloc.add(UpdateChannelSelected(channel));
                unawaited(context.router.maybePop());
              },
            ),
          ],
        ),
      ),
    );
  }
}
