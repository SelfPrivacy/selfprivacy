import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';

class ServerJobCard extends StatelessWidget {
  const ServerJobCard({
    required final this.serverJob,
    final super.key,
  });

  final ServerJob serverJob;

  @override
  Widget build(final BuildContext context) => GestureDetector(
        child: BrandCards.big(
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
              const SizedBox(height: 8),
              BrandLinearIndicator(
                value: serverJob.progress == null
                    ? 0.0
                    : serverJob.progress! / 100.0,
                color: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                height: 7.0,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
}
