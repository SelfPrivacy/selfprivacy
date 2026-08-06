import 'dart:async';

import 'package:duration/duration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/token_renewal_schedule.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';

class TokenRenewalSubtitle extends StatefulWidget {
  const TokenRenewalSubtitle({required this.resourcesModel, super.key});

  final ResourcesModel resourcesModel;

  @override
  State<TokenRenewalSubtitle> createState() => _TokenRenewalSubtitleState();
}

class _TokenRenewalSubtitleState extends State<TokenRenewalSubtitle> {
  Timer? _timer;
  StreamSubscription<ResourcesModelEvent>? _resourcesSubscription;

  @override
  void initState() {
    super.initState();
    _resourcesSubscription = widget.resourcesModel.statusStream.listen((_) {
      if (mounted) {
        setState(() {});
      }
    });
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    unawaited(_resourcesSubscription?.cancel());
    super.dispose();
  }

  TokenRenewalSchedule get _schedule {
    final servers = widget.resourcesModel.servers;
    final details = servers.isEmpty ? null : servers.first.hostingDetails;
    return TokenRenewalSchedule.fromToken(
      token: details?.apiToken,
      rotatedAt: details?.apiTokenRotatedAt,
    );
  }

  @override
  Widget build(final BuildContext context) => Text(switch (_schedule.state) {
    TokenRenewalState.noToken =>
      'developer_settings.token_renewal_no_token'.tr(),
    TokenRenewalState.dueNow => 'developer_settings.token_renewal_due_now'.tr(),
    TokenRenewalState.scheduled => _scheduledRenewal(_schedule.renewalAt!),
  });

  String _scheduledRenewal(final DateTime renewalAt) {
    final now = DateTime.now();
    if (renewalAt.isAfter(now)) {
      return 'developer_settings.token_renewal_next'.tr(
        args: [_relativeDuration(renewalAt.difference(now))],
      );
    }
    return 'developer_settings.token_renewal_overdue'.tr(
      args: [_relativeDuration(now.difference(renewalAt))],
    );
  }

  String _relativeDuration(final Duration duration) {
    final displayDuration = duration.inMinutes == 0
        ? const Duration(minutes: 1)
        : duration;
    return displayDuration.toPrettyString(
      context.locale,
      tersity: DurationTersity.minute,
      upperTersity: DurationTersity.day,
      maxUnits: 1,
    );
  }
}
