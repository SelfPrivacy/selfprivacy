import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';

part 'dns_records_state.dart';

class DnsRecordsCubit extends Cubit<DnsRecordsState> {
  DnsRecordsCubit({
    required final Stream<bool?> access,
    required final Future<GenericResult<List<DesiredDnsRecord>>> Function()
    read,
    required final Future<GenericResult<List<DesiredDnsRecord>>?> Function()
    repair,
  }) : _read = read,
       _repair = repair,
       super(DnsRecordsState()) {
    _subscription = access.listen((final observation) {
      _access = observation;
      _accessRevision++;
      if (observation == null) {
        _requested = false;
        _request = null;
        _repairing = false;
        emit(DnsRecordsState());
      }
      if ((observation ?? false) && !_requested && !_repairing) {
        unawaited(load());
      }
    });
  }

  final Future<GenericResult<List<DesiredDnsRecord>>> Function() _read;
  final Future<GenericResult<List<DesiredDnsRecord>>?> Function() _repair;
  late final StreamSubscription<bool?> _subscription;
  bool? _access;
  bool _requested = false;
  int _accessRevision = 0;
  Object? _request;
  bool _repairing = false;

  bool get _isActive => !isClosed && _access != null;

  Future<void> load() async {
    final revision = _accessRevision;
    if (isClosed || _repairing || _access != true) {
      return;
    }
    final request = _request = Object();
    _requested = true;
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    try {
      final result = await _read();
      if (_isActive && identical(_request, request)) {
        _publish(result);
      }
    } on GraphQLDispatchDeferred {
      if (_isActive && identical(_request, request)) {
        _requested = false;
        if ((_access ?? false) && revision != _accessRevision) {
          unawaited(load());
        }
      }
    } catch (_) {
      if (_isActive && identical(_request, request)) {
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
    if (!_isActive || _repairing) {
      return;
    }
    _repairing = true;
    _request = Object();
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    try {
      final result = await _repair();
      if (_isActive) {
        if (result != null) {
          _publish(result);
        } else {
          emit(state.copyWith(dnsState: DnsRecordsStatus.error));
        }
      }
    } catch (_) {
      if (_isActive) {
        emit(state.copyWith(dnsState: DnsRecordsStatus.error));
      }
    } finally {
      if (_isActive) {
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
