import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

/// Fake data collections to fill skeletons
class FakeSelfPrivacyData {
  static final List<DesiredDnsRecord> desiredDnsRecords = <DesiredDnsRecord>[
    ...List.generate(
      6,
      (final index) => const DesiredDnsRecord(
        type: 'A',
        name: 'example.com',
        description: 'Service name',
        content: '192.0.2.100',
      ),
    ),
    ...List.generate(
      4,
      (final index) => const DesiredDnsRecord(
        type: 'TXT',
        name: 'example.com',
        description: 'Service name',
        content: 'Some text text text',
      ),
    ),
    const DesiredDnsRecord(
      type: 'CAA',
      name: 'example.com',
      description: 'Service name',
      content: 'Some very very long text text text',
    ),
  ];

  static final ApiToken thisDeviceToken = ApiToken(
    name: 'Error fetching device',
    isCaller: true,
    date: DateTime.now(),
  );

  static final ApiToken otherDeviceToken = ApiToken(
    name: 'Error fetching device',
    isCaller: false,
    date: DateTime.now(),
  );
}
