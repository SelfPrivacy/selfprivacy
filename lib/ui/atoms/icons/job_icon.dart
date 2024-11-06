import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

IconData getJobIcon(final JobStatusEnum status) {
  switch (status) {
    case JobStatusEnum.created:
      return Icons.query_builder_outlined;
    case JobStatusEnum.running:
      return Icons.pending_outlined;
    case JobStatusEnum.finished:
      return Icons.check_circle_outline;
    case JobStatusEnum.error:
      return Icons.error_outline;
  }
}

Color getJobColor(final JobStatusEnum status, final BuildContext context) {
  switch (status) {
    case JobStatusEnum.created:
      return Theme.of(context).colorScheme.secondary;
    case JobStatusEnum.running:
      return Theme.of(context).colorScheme.tertiary;
    case JobStatusEnum.finished:
      return Theme.of(context).colorScheme.primary;
    case JobStatusEnum.error:
      return Theme.of(context).colorScheme.error;
  }
}
