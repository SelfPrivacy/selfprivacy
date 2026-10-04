import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';

enum CommandApplication { applied, notApplied, failed, detached }

class CommandCompletion<T> {
  const CommandCompletion(this.application, {this.result});

  final CommandApplication application;

  /// Null when never sent or detached before the remote result was available.
  final ServerMutationResult<T>? result;
}

class _Command {
  _Command(this.domains, this.start, this.detach);

  final Set<DomainStore<Object>> domains;
  final void Function() start;
  final void Function() detach;
  bool running = false;
}

/// Orders conflicting commands for a fixed server and transport generation.
/// Dispose this coordinator before disposing or replacing its stores.
class ServerCommandCoordinator {
  ServerCommandCoordinator({
    required this.origin,
    required final ServerStateOrigin? Function() currentOrigin,
    required final ServerApi api,
    required final Iterable<DomainStore<Object>> stores,
    final DomainStore<Version>? apiVersion,
  }) : _currentOrigin = currentOrigin,
       _api = api,
       _apiVersion = apiVersion,
       _stores = Set.unmodifiable(stores);

  final ServerStateOrigin origin;
  final ServerStateOrigin? Function() _currentOrigin;
  final ServerApi _api;
  final DomainStore<Version>? _apiVersion;
  final Set<DomainStore<Object>> _stores;
  final _commands = <_Command>[];
  final _changes = StreamController<void>.broadcast();
  bool _disposed = false;
  bool _draining = false;

  Stream<void> get changes => _changes.stream;

  bool isReserved(final DomainStore<Object> store) => _commands.any(
    (final command) => command.running && command.domains.contains(store),
  );

  bool get _attached =>
      !_disposed &&
      identical(_currentOrigin(), origin) &&
      _stores.every((final store) => !store.isDisposed);

  bool get isAttached => _attached;

  bool owns(final DomainStore<Object> store) => _stores.contains(store);

  Future<ServerMutationResult<T>> mutate<T>({
    required final Iterable<DomainStore<Object>> domains,
    required final Future<ServerMutationResult<T>> Function(ServerApi) send,
    final Iterable<DomainStore<Object>> Function(ServerMutationResult<T>)?
    applyConfirmed,
  }) async {
    final result = await _mutate(
      domains: domains,
      send: (final api) {
        GraphQLDispatchGuard.current?.check();
        return send(api);
      },
      applyConfirmed: applyConfirmed,
    );
    OperationExecution.current?.record(result);
    return result;
  }

  Future<ServerMutationResult<T>> _mutate<T>({
    required final Iterable<DomainStore<Object>> domains,
    required final Future<ServerMutationResult<T>> Function(ServerApi) send,
    final Iterable<DomainStore<Object>> Function(ServerMutationResult<T>)?
    applyConfirmed,
  }) async {
    if (isAttached && _apiVersion != null && _apiVersion.value.data == null) {
      await _refreshVersion();
    }
    final affected = domains.toSet();
    if (!_stores.containsAll(affected)) {
      throw ArgumentError('Store belongs to another coordinator.');
    }
    if (!isAttached ||
        affected.any(
          (final store) => store.value.support != DomainSupport.supported,
        )) {
      return ServerMutationResult<T>(
        outcome: ServerMutationOutcome.indeterminate,
        payload: const ServerMutationPayload.notExpected(),
      );
    }
    final completion = await submit<T>(
      domains: affected,
      send: send,
      applyConfirmed: applyConfirmed,
    );
    if (!isAttached || completion.application == CommandApplication.detached) {
      return ServerMutationResult<T>(
        outcome: ServerMutationOutcome.indeterminate,
        payload: const ServerMutationPayload.unreadable(),
      );
    }
    final result = completion.result!;
    return result;
  }

  Future<RefreshResult> _refreshVersion() => _apiVersion!.refresh(
    force: _apiVersion.value.lastError != null,
    acceptResult: () => isAttached,
  );

  /// [send] must use the supplied API and must not replay the mutation.
  /// [applyConfirmed] runs synchronously and returns the domains its effects
  /// cover. Uncovered domains remain due for reconciliation. Rejected and
  /// indeterminate results never reach this callback.
  Future<CommandCompletion<T>> submit<T>({
    required final Iterable<DomainStore<Object>> domains,
    required final Future<ServerMutationResult<T>> Function(ServerApi api) send,
    final Iterable<DomainStore<Object>> Function(
      ServerMutationResult<T> result,
    )?
    applyConfirmed,
  }) {
    final affected = Set<DomainStore<Object>>.unmodifiable(domains);
    if (affected.isEmpty || !_stores.containsAll(affected)) {
      throw ArgumentError(
        'Commands must declare domains from this coordinator.',
      );
    }
    final completion = Completer<CommandCompletion<T>>();
    final boundSend = Zone.current.bindUnaryCallback(send);
    late final _Command command;
    command = _Command(
      affected,
      () => unawaited(_run(command, boundSend, applyConfirmed, completion)),
      () {
        if (!completion.isCompleted) {
          completion.complete(
            CommandCompletion<T>(CommandApplication.detached),
          );
        }
      },
    );
    if (!_attached) {
      dispose();
      command.detach();
    } else {
      _commands.add(command);
      _publish();
      _drain();
    }
    return completion.future;
  }

  void _drain() {
    if (_disposed) {
      return;
    }
    if (_draining) {
      scheduleMicrotask(_drain);
      return;
    }
    if (!_attached) {
      dispose();
      return;
    }
    _draining = true;
    try {
      final blocked = <DomainStore<Object>>{};
      for (final command in _commands.toList()) {
        if (!_attached) {
          dispose();
          break;
        }
        final conflicts = command.domains.any(blocked.contains);
        blocked.addAll(command.domains);
        if (!command.running && !conflicts) {
          command.running = true;
          _publish();
          command.start();
        }
      }
    } finally {
      _draining = false;
    }
  }

  Future<void> _run<T>(
    final _Command command,
    final Future<ServerMutationResult<T>> Function(ServerApi api) send,
    final Iterable<DomainStore<Object>> Function(
      ServerMutationResult<T> result,
    )?
    applyConfirmed,
    final Completer<CommandCompletion<T>> completion,
  ) async {
    ServerMutationResult<T>? result;
    var application = CommandApplication.notApplied;
    try {
      for (final domain in command.domains) {
        domain.fenceReads();
      }
      try {
        result = await send(_api);
      } catch (_) {
        result = ServerMutationResult<T>(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.unreadable(),
        );
      }
      if (!_attached) {
        application = CommandApplication.detached;
      } else {
        final covered = <DomainStore<Object>>{};
        if (result.outcome == ServerMutationOutcome.confirmed &&
            applyConfirmed != null) {
          covered.addAll(applyConfirmed(result));
          if (!command.domains.containsAll(covered)) {
            throw StateError('Command effects covered undeclared domains.');
          }
          application = CommandApplication.applied;
        }
        for (final domain in command.domains.difference(covered)) {
          domain.invalidate();
        }
      }
    } catch (_) {
      // Preserve remote confirmation if a local reducer fails.
      application = _attached
          ? CommandApplication.failed
          : CommandApplication.detached;
      if (_attached) {
        for (final domain in command.domains) {
          domain.invalidate();
        }
      }
    } finally {
      _commands.remove(command);
      _publish();
      if (!completion.isCompleted) {
        completion.complete(CommandCompletion(application, result: result));
      }
      _drain();
    }
  }

  void _publish() {
    if (_disposed) {
      return;
    }
    _changes.add(null);
  }

  /// Resolves local waiters without cancelling requests already sent.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    for (final command in _commands) {
      command.detach();
    }
    _commands.clear();
    _changes.add(null);
    unawaited(_changes.close());
  }
}
