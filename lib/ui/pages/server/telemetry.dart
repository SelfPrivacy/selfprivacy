import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/forms/telemetry_form.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/telemetry_settings.dart';
import 'package:selfprivacy/ui/forms/telemetry_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

@RoutePage()
class TelemetryPage extends StatefulWidget {
  const TelemetryPage({super.key});
  @override
  State<TelemetryPage> createState() => _TelemetryPageState();
}

class _TelemetryPageState extends State<TelemetryPage> {
  TelemetryForm? _form;
  TelemetrySettings? _loaded;
  TelemetryUpdate? _pending;

  void _synchronize(final ServerSettingsState state) {
    final data = state.telemetry.data;
    final pending = state.pending<ChangeTelemetrySettingsJob>()?.settings;
    if (data != null &&
        (_form == null ||
            (_form!.form.pristine &&
                (data != _loaded || pending != _pending)))) {
      _form?.dispose();
      _loaded = data;
      _pending = pending;
      _form = TelemetryForm(data, pending: pending);
    }
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ServerSettingsBloc>();
    _synchronize(bloc.state);
    unawaited(bloc.refresh());
  }

  @override
  void dispose() {
    _form?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final bloc = context.read<ServerSettingsBloc>();
    final scrollBehavior = ScrollConfiguration.of(context);
    return BlocConsumer<ServerSettingsBloc, ServerSettingsState>(
      listener: (_, final state) => _synchronize(state),
      builder: (final context, final state) => RefreshIndicator(
        onRefresh: bloc.refresh,
        child: ScrollConfiguration(
          behavior: scrollBehavior.copyWith(
            physics: AlwaysScrollableScrollPhysics(
              parent: scrollBehavior.getScrollPhysics(context),
            ),
          ),
          child: BrandHeroScreen(
            heroIcon: Icons.monitor_heart_outlined,
            heroTitle: 'server.telemetry.title'.tr(),
            children: [
              TelemetryFormView(
                form: _form,
                snapshot: state.telemetry,
                pending: state.pending<ChangeTelemetrySettingsJob>() != null,
                enabled: state.canEditTelemetry,
                applying: state is ServerSettingsApplying,
                onRefresh: () => unawaited(bloc.refresh()),
                onShowOperation: () =>
                    unawaited(showModalJobsSheet(context: context)),
                onAdd: (final update) {
                  if (!bloc.state.canEditTelemetry) {
                    return;
                  }
                  bloc.add(TelemetrySettingsSelected(update));
                  unawaited(context.router.maybePop());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
