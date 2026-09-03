import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/digital_ocean/digital_ocean_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

import '../../../../helpers/fixtures/json_fixture.dart';

void main() {
  test('parses and converts DigitalOcean records with omitted fields', () {
    final records =
        (loadJsonFixture(
                  'dns_providers/digital_ocean/records.json',
                )['domain_records']
                as List<dynamic>)
            .map(
              (final record) => DigitalOceanDnsRecord.fromJson(
                record as Map<String, dynamic>,
              ),
            )
            .toList();

    expect(
      records[0].toDnsRecord('example.com'),
      const DnsRecord(
        type: 'A',
        name: 'example.com',
        content: '192.0.2.1',
        ttl: 1800,
      ),
    );
    expect(records[1].ttl, isNull);
    expect(
      records[1].toDnsRecord('example.com'),
      const DnsRecord(type: 'A', name: 'www', content: '192.0.2.2'),
    );
    expect(records[2].name, isNull);
    expect(records[2].data, isNull);
    expect(
      records[2].toDnsRecord('example.com'),
      const DnsRecord(type: 'SOA', name: null, content: null),
    );
  });

  test('serializes complete outbound records as before', () {
    final record = DigitalOceanDnsRecord.fromDnsRecord(
      const DnsRecord(
        type: 'A',
        name: 'example.com',
        content: '192.0.2.1',
        ttl: 7200,
      ),
      'example.com',
    );

    expect(record.toJson(), containsPair('type', 'A'));
    expect(record.toJson(), containsPair('name', '@'));
    expect(record.toJson(), containsPair('data', '192.0.2.1'));
    expect(record.toJson(), containsPair('ttl', 7200));
  });
}
