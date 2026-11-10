import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/telemetry_settings.dart';
import 'package:selfprivacy/logic/operations/change_draft.dart';

class TelemetryRepository {
  TelemetryRepository({
    required this.commands,
    required this.reader,
    required final ChangeDraft draft,
  }) : _draft = draft {
    if (!commands.owns(reader.store)) {
      throw ArgumentError('Telemetry store belongs to another connection.');
    }
  }
  final ServerCommandCoordinator commands;
  final DomainReader<TelemetrySettings> reader;
  final ChangeDraft _draft;

  CachedValue<TelemetrySettings> get value => reader.value;
  Stream<CachedValue<TelemetrySettings>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  bool stageChange(final ChangeTelemetrySettingsJob change) {
    if (!commands.isAttached ||
        value.support != DomainSupport.supported ||
        value.data == null) {
      return false;
    }
    return _matchesCurrent(change.settings)
        ? _draft.removeWhere(change.replaces)
        : _draft.add(change);
  }

  void reconcileDraft() {
    final snapshot = value;
    if (snapshot.support != DomainSupport.supported ||
        snapshot.freshness != Freshness.fresh ||
        snapshot.lastError != null ||
        snapshot.needsReconciliation) {
      return;
    }
    _draft.removeWhere(
      (final change) =>
          change is ChangeTelemetrySettingsJob &&
          _matchesCurrent(change.settings),
    );
  }

  bool _matchesCurrent(final TelemetryUpdate settings) {
    final current = value.data;
    return current != null && settings == TelemetryUpdate.fromSettings(current);
  }

  Future<ServerMutationResult<TelemetrySettings>> save(
    final TelemetryUpdate settings,
  ) => commands.mutate(
    domains: [reader.store],
    send: (final api) => api.setTelemetrySettings(settings),
    applyConfirmed: (final result) {
      final returned = result.payload.value;
      if (returned == null) {
        return [];
      }
      reader.store.push(returned);
      return [reader.store];
    },
  );
}
