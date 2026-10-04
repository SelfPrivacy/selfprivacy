import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';

import '../../../../helpers/fixtures/dns_record_fixtures.dart';

void main() {
  for (final close in [false, true]) {
    test(
      'late DNS validation cannot publish after ${close ? 'close' : 'reset'}',
      () async {
        final access = StreamController<ConnectionObservation<bool>>(
          sync: true,
        );
        final pending = Completer<GenericResult<List<DesiredDnsRecord>>>();
        final cubit = DnsRecordsCubit(
          access: access.stream,
          read: (_) => pending.future,
          repair: (_) async => null,
        );
        addTearDown(() async {
          await cubit.close();
          await access.close();
        });
        access.add(
          ConnectionObservation.attached(ServerStateOrigin('server'), true),
        );
        if (close) {
          await cubit.close();
        } else {
          access.add(const ConnectionObservation.absent());
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
    final access = StreamController<ConnectionObservation<bool>>(sync: true);
    final records = [aDesiredDnsRecord()];
    final cubit = DnsRecordsCubit(
      access: access.stream,
      read: (_) async => GenericResult(success: true, data: records),
      repair: (_) async => null,
    );
    addTearDown(() async {
      await cubit.close();
      await access.close();
    });
    final origin = ServerStateOrigin('server');
    access.add(ConnectionObservation.attached(origin, true));
    await pumpEventQueue();
    final before = cubit.state;
    records.clear();
    access.add(ConnectionObservation.attached(origin, false));
    expect(cubit.state, same(before));
    expect(before.dnsRecords, hasLength(1));
    expect(before.dnsRecords.clear, throwsUnsupportedError);
  });
}
