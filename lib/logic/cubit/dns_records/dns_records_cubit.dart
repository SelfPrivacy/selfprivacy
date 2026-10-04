import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';

part 'dns_records_state.dart';

class DnsRecordsCubit extends Cubit<DnsRecordsState> {
  DnsRecordsCubit({
    required final Stream<ConnectionObservation<bool>> access,
    required final Future<GenericResult<List<DesiredDnsRecord>>> Function(
      ServerStateOrigin,
    )
    read,
    required final Future<GenericResult<List<DesiredDnsRecord>>?> Function(
      ServerStateOrigin,
    )
    repair,
  }) : _read = read,
       _repair = repair,
       super(DnsRecordsState()) {
    _subscription = access.listen((final observation) {
      final previous = _access;
      _access = observation;
      if (!identical(
        previous?.origin?.continuity,
        observation.origin?.continuity,
      )) {
        _requestedOrigin = null;
        _request = null;
        _repairing = false;
        emit(DnsRecordsState());
      }
      if ((observation.value ?? false) &&
          !identical(_requestedOrigin, observation.origin) &&
          !_repairing) {
        unawaited(load());
      }
    });
  }

  final Future<GenericResult<List<DesiredDnsRecord>>> Function(
    ServerStateOrigin,
  )
  _read;
  final Future<GenericResult<List<DesiredDnsRecord>>?> Function(
    ServerStateOrigin,
  )
  _repair;
  late final StreamSubscription<ConnectionObservation<bool>> _subscription;
  ConnectionObservation<bool>? _access;
  ServerStateOrigin? _requestedOrigin;
  Object? _request;
  bool _repairing = false;

  bool _isCurrent(final ServerStateOrigin origin) =>
      !isClosed && identical(origin.continuity, _access?.origin?.continuity);

  Future<void> load() async {
    final access = _access;
    final origin = access?.origin;
    if (isClosed || _repairing || origin == null || !(access?.value ?? false)) {
      return;
    }
    final request = _request = Object();
    _requestedOrigin = origin;
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    try {
      final result = await _read(origin);
      if (_isCurrent(origin) &&
          identical(_request, request) &&
          identical(origin, _access?.origin)) {
        _publish(result);
      }
    } on GraphQLDispatchDeferred {
      if (_isCurrent(origin) && identical(_request, request)) {
        _requestedOrigin = null;
        if ((_access?.value ?? false) && !identical(access, _access)) {
          unawaited(load());
        }
      }
    } catch (_) {
      if (_isCurrent(origin) && identical(_request, request)) {
        emit(state.copyWith(dnsState: DnsRecordsStatus.error));
      }
    }
  }

  void _publish(final GenericResult<List<DesiredDnsRecord>> result) {
    emit(
      DnsRecordsState(
        dnsRecords: result.data,
        dnsState:
            !result.success ||
                result.data.any((final record) => !record.isSatisfied)
            ? DnsRecordsStatus.error
            : result.data.isEmpty
            ? DnsRecordsStatus.uninitialized
            : DnsRecordsStatus.good,
      ),
    );
  }

  Future<void> refresh() => load();

  Future<void> fix() async {
    final origin = _access?.origin;
    if (isClosed || origin == null || _repairing) {
      return;
    }
    _repairing = true;
    _request = Object();
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    try {
      final result = await _repair(origin);
      if (_isCurrent(origin)) {
        if (result != null) {
          _publish(result);
        } else {
          emit(state.copyWith(dnsState: DnsRecordsStatus.error));
        }
      }
    } catch (_) {
      if (_isCurrent(origin)) {
        emit(state.copyWith(dnsState: DnsRecordsStatus.error));
      }
    } finally {
      if (_isCurrent(origin)) {
        _repairing = false;
      }
    }
  }

  @override
  Future<void> close() async {
    _access = null;
    _request = null;
    await _subscription.cancel();
    return super.close();
  }
}
