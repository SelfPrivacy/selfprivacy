import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/change_draft.dart';

class CredentialPolicyRepository {
  CredentialPolicyRepository({
    required this.commands,
    required this.reader,
    required final ChangeDraft draft,
  }) : _draft = draft {
    if (!commands.owns(reader.store)) {
      throw ArgumentError(
        'Credential policy store belongs to another connection.',
      );
    }
  }

  final ServerCommandCoordinator commands;
  final DomainReader<CredentialPolicy> reader;
  final ChangeDraft _draft;

  CachedValue<CredentialPolicy> get value => reader.value;
  Stream<CachedValue<CredentialPolicy>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  bool stageChange(final ChangeCredentialPolicyJob change) {
    final snapshot = value;
    if (!commands.isAttached ||
        snapshot.support != DomainSupport.supported ||
        snapshot.data == null ||
        change.policy == CredentialPolicy.unknown) {
      return false;
    }
    return change.policy == snapshot.data
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
          change is ChangeCredentialPolicyJob && change.policy == snapshot.data,
    );
  }

  Future<ServerMutationResult<CredentialPolicy>> setPolicy(
    final CredentialPolicy policy,
  ) {
    if (policy == CredentialPolicy.unknown) {
      throw ArgumentError('Unknown credential policy cannot be submitted.');
    }
    return commands.mutate(
      domains: [reader.store],
      send: (final api) => api.setCredentialPolicy(policy),
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
}
