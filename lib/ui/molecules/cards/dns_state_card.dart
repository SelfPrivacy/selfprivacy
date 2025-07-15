import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';

class DnsStateCard extends StatelessWidget {
  const DnsStateCard({
    required this.dnsState,
    required this.fixCallback,
    super.key,
  });

  final DnsRecordsStatus dnsState;
  final GestureTapCallback fixCallback;

  @override
  Widget build(final BuildContext context) {
    String description = '';
    String subtitle = '';
    Icon icon = const Icon(Icons.check_circle_outline, size: 24);
    bool isError = false;
    switch (dnsState) {
      case DnsRecordsStatus.uninitialized:
        description = 'domain.uninitialized'.tr();
        icon = const Icon(Icons.refresh, size: 24);
        isError = false;
      case DnsRecordsStatus.refreshing:
        description = 'domain.refreshing'.tr();
        icon = const Icon(Icons.refresh, size: 24);
        isError = false;
      case DnsRecordsStatus.good:
        description = 'domain.ok'.tr();
        icon = const Icon(Icons.check_circle_outline, size: 24);
        isError = false;
      case DnsRecordsStatus.error:
        description = 'domain.error'.tr();
        subtitle = 'domain.error_subtitle'.tr();
        icon = const Icon(Icons.error_outline, size: 24);
        isError = true;
    }
    return FilledCard(
      error: isError,
      child: ListTile(
        onTap: dnsState == DnsRecordsStatus.error ? fixCallback : null,
        leading: icon,
        title: Text(description),
        subtitle: subtitle != '' ? Text(subtitle) : null,
        textColor:
            isError
                ? Theme.of(context).colorScheme.onErrorContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
        iconColor:
            isError
                ? Theme.of(context).colorScheme.onErrorContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
