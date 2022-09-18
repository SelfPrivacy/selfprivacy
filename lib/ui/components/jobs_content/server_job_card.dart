import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';

class ServerJobCard extends StatelessWidget {
  const ServerJobCard({
    required final this.serverJob,
    final super.key,
  });

  final ServerJob serverJob;

  @override
  Widget build(final BuildContext context) {
    Color color;
    IconData icon;

    switch (serverJob.status) {
      case JobStatusEnum.created:
        color = Theme.of(context).colorScheme.secondary;
        icon = Icons.query_builder_outlined;
        break;
      case JobStatusEnum.running:
        color = Theme.of(context).colorScheme.tertiary;
        icon = Icons.pending_outlined;
        break;
      case JobStatusEnum.finished:
        color = Theme.of(context).colorScheme.primary;
        icon = Icons.check_circle_outline;
        break;
      case JobStatusEnum.error:
        color = Theme.of(context).colorScheme.error;
        icon = Icons.error_outline;
        break;
    }

    final String? statusString =
        serverJob.error ?? serverJob.result ?? serverJob.statusText;

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serverJob.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        serverJob.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    icon,
                    color: color,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              BrandLinearIndicator(
                value: serverJob.progress == null
                    ? 0.0
                    : serverJob.progress! / 100.0,
                color: color,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                height: 7.0,
              ),
              const SizedBox(height: 8),
              if (statusString != null)
                Text(
                  statusString,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
