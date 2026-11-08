import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    required this.icon,
    required this.message,
    this.title,
    this.onTap,
    this.isNavigation = false,
    this.isError = false,
    super.key,
  });

  factory StatusCard.stale({
    required final VoidCallback onRefresh,
    final bool refreshing = false,
  }) => StatusCard(
    icon: Icons.history_outlined,
    title: 'data_status.stale_title'.tr(),
    message: (refreshing ? 'data_status.refreshing' : 'data_status.stale').tr(),
    onTap: refreshing ? null : onRefresh,
  );

  factory StatusCard.loadError({
    required final String title,
    required final VoidCallback onRetry,
    final bool retrying = false,
  }) => StatusCard(
    icon: Icons.cloud_off_outlined,
    title: title,
    message: (retrying ? 'data_status.retrying' : 'data_status.retry').tr(),
    isError: true,
    onTap: retrying ? null : onRetry,
  );

  final IconData icon;
  final String message;
  final String? title;
  final VoidCallback? onTap;
  final bool isNavigation;
  final bool isError;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final color = isError
        ? theme.colorScheme.onErrorContainer
        : theme.colorScheme.onSurfaceVariant;
    return FilledCard(
      error: isError,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(color: color),
                    ),
                  ],
                ),
              ),
              if (onTap != null && isNavigation) ...[
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: color),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
