import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';

/// Identity of one server's cache and transport generation.
/// Create a new instance when either binding is replaced, even for the same UUID.
class ServerStateOrigin {
  ServerStateOrigin(this.serverId);

  final String serverId;
}

enum CommandPhase { queued, running }

enum CommandApplication { applied, notApplied, failed, detached }

/// Observable metadata excludes command arguments, results and error text.
class PendingCommand {
  PendingCommand({
    required this.id,
    required this.phase,
    required final Iterable<String> domains,
  }) : domains = Set.unmodifiable(domains);

  final Object id;
  final CommandPhase phase;
  final Set<String> domains;
}

class CommandCompletion<T> {
  const CommandCompletion(this.application, {this.result});

  final CommandApplication application;

  /// Null when never sent or detached before the remote result was available.
  final ServerMutationResult<T>? result;
}

class CommandHandle<T> {
  CommandHandle._(this.id, this.completion, this.remoteResult);

  final Object id;

  /// Resolves after local publication, or immediately on coordinator disposal.
  final Future<CommandCompletion<T>> completion;

  /// Preserves late remote results after detachment. Null means never sent.
  /// This future can outlive the coordinator and contains sensitive payloads.
  final Future<ServerMutationResult<T>?> remoteResult;
}

class _Command {
  _Command(this.domains, this.start, this.detach);

  final id = Object();
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
  }) : _currentOrigin = currentOrigin,
       _api = api,
       _stores = Set.unmodifiable(stores);

  final ServerStateOrigin origin;
  final ServerStateOrigin? Function() _currentOrigin;
  final ServerApi _api;
  final Set<DomainStore<Object>> _stores;
  final _commands = <_Command>[];
  final _changes = StreamController<List<PendingCommand>>.broadcast();
  List<PendingCommand> _pending = const [];
  bool _disposed = false;
  bool _draining = false;

  List<PendingCommand> get pending => _pending;
  Stream<List<PendingCommand>> get changes => _changes.stream;

  bool isReserved(final DomainStore<Object> store) => _commands.any(
    (final command) => command.running && command.domains.contains(store),
  );

  bool get _attached =>
      !_disposed &&
      identical(_currentOrigin(), origin) &&
      _stores.every((final store) => !store.isDisposed);

  bool get isAttached => _attached;

  bool owns(final DomainStore<Object> store) => _stores.contains(store);

  /// [send] must use the supplied API and must not replay the mutation.
  /// [applyConfirmed] runs synchronously and returns the domains its effects
  /// cover. Uncovered domains remain due for reconciliation. Rejected and
  /// indeterminate results never reach this callback.
  CommandHandle<T> submit<T>({
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
    final remote = Completer<ServerMutationResult<T>?>();
    late final _Command command;
    command = _Command(
      affected,
      () => unawaited(_run(command, send, applyConfirmed, completion, remote)),
      () {
        if (!completion.isCompleted) {
          completion.complete(
            CommandCompletion<T>(CommandApplication.detached),
          );
        }
        if (!command.running && !remote.isCompleted) {
          remote.complete(null);
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
    return CommandHandle._(command.id, completion.future, remote.future);
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
    final Completer<ServerMutationResult<T>?> remote,
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
      remote.complete(result);
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
      if (!remote.isCompleted) {
        remote.complete(null);
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
    _pending = List.unmodifiable([
      for (final command in _commands)
        PendingCommand(
          id: command.id,
          phase: command.running ? CommandPhase.running : CommandPhase.queued,
          domains: command.domains.map((final domain) => domain.name),
        ),
    ]);
    _changes.add(_pending);
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
    _pending = const [];
    _changes.add(_pending);
    unawaited(_changes.close());
  }
}
