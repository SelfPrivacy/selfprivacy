import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';

import '../../../../helpers/fixtures/dns_record_fixtures.dart';

void main() {
  for (final close in [false, true]) {
    test(
      'late DNS validation cannot publish after ${close ? 'close' : 'reset'}',
      () async {
        final access = StreamController<bool?>(sync: true);
        final pending = Completer<GenericResult<List<DesiredDnsRecord>>>();
        final cubit = DnsRecordsCubit(
          access: access.stream,
          read: () => pending.future,
          repair: () async => null,
        );
        addTearDown(() async {
          await cubit.close();
          await access.close();
        });
        access.add(true);
        if (close) {
          await cubit.close();
        } else {
          access.add(null);
        }
        pending.complete(
          GenericResult(success: true, data: [aDesiredDnsRecord()]),
        );
        await pumpEventQueue();
        expect(cubit.state.dnsRecords, isEmpty);
      },
    );
  }

  test('validated records are immutable and retained while offline', () async {
    final access = StreamController<bool?>(sync: true);
    final records = [aDesiredDnsRecord()];
    final cubit = DnsRecordsCubit(
      access: access.stream,
      read: () async => GenericResult(success: true, data: records),
      repair: () async => null,
    );
    addTearDown(() async {
      await cubit.close();
      await access.close();
    });
    access.add(true);
    await pumpEventQueue();
    final before = cubit.state;
    records.clear();
    access.add(false);
    expect(cubit.state, same(before));
    expect(before.dnsRecords, hasLength(1));
    expect(before.dnsRecords.clear, throwsUnsupportedError);
  });
}
