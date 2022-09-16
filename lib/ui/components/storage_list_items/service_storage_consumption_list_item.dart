import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';

class ServiceStorageConsumptionListItem extends StatelessWidget {
  const ServiceStorageConsumptionListItem({
    required this.title,
    required this.percentage,
    required this.storageConsumptionText,
    required this.color,
    required this.icon,
    final super.key,
  });

  final String title;
  final double percentage;
  final String storageConsumptionText;
  final Color color;
  final IconData icon;
  @override
  Widget build(final BuildContext context) => Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      storageConsumptionText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                BrandLinearIndicator(
                  value: percentage,
                  color: color,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  height: 7.0,
                ),
              ],
            ),
          ),
        ],
      );
}
