import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

DnsRecord aDnsRecord() =>
    const DnsRecord(name: 'gitea', type: 'A', content: '203.0.113.10');

DesiredDnsRecord aDesiredDnsRecord({final bool isSatisfied = true}) =>
    DesiredDnsRecord(
      name: 'gitea',
      content: '203.0.113.10',
      isSatisfied: isSatisfied,
    );
