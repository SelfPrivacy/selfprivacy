import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';

class DnsRecordItem extends StatelessWidget {
  const DnsRecordItem({
    required this.dnsRecord,
    required this.refreshing,
    super.key,
  });

  final DesiredDnsRecord dnsRecord;
  final bool refreshing;
  @override
  Widget build(final BuildContext context) {
    final Color goodColor = Theme.of(context).colorScheme.onSurface;
    final Color errorColor = Theme.of(context).colorScheme.error;
    final Color neutralColor = Theme.of(context).colorScheme.onSurface;

    return ListTile(
      leading: Icon(
        dnsRecord.isSatisfied
            ? Icons.check_circle_outline
            : refreshing
            ? Icons.refresh
            : Icons.error_outline,
        color:
            dnsRecord.isSatisfied
                ? goodColor
                : refreshing
                ? neutralColor
                : errorColor,
      ),
      title: Text(dnsRecord.displayName ?? dnsRecord.name),
      subtitle: Text(
        dnsRecord.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
