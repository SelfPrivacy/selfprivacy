import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/atoms/masks/icon_status_mask.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProvidersPageCard extends StatelessWidget {
  const ProvidersPageCard({
    required this.state,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  final Function()? onTap;
  final StateType state;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Skeleton.shade(
                  child: IconStatusMask(
                    status: state,
                    icon: Icon(icon, size: 32, color: Colors.white),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Skeleton.shade(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                if (state != StateType.uninitialized)
                  IconStatusMask(
                    status: state,
                    icon: Icon(
                      state == StateType.stable
                          ? Icons.check_circle_outline
                          : state == StateType.warning
                          ? Icons.warning_amber_outlined
                          : Icons.error_outline,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (state != StateType.uninitialized)
              Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    ),
  );
}
