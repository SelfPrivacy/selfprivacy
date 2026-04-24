import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/atoms/icons/job_icon.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/brand_linear_indicator.dart';

class ServerJobCard extends StatelessWidget {
  const ServerJobCard({required this.serverJob, super.key});

  final ServerJob serverJob;

  @override
  Widget build(final BuildContext context) {
    Color color;
    IconData icon;

    color = getJobColor(serverJob.status, context);
    icon = getJobIcon(serverJob.status);

    final String? statusString =
        serverJob.error ?? serverJob.result ?? serverJob.statusText;

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
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
                  ),
                  Icon(icon, color: color),
                ],
              ),
              const SizedBox(height: 8),
              BrandLinearIndicator(
                value:
                    serverJob.progress == null
                        ? 0.0
                        : serverJob.progress! / 100.0,
                color: color,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                height: 8,
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
