import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';
import 'package:selfprivacy/logic/operations/change_draft.dart';

class UpdateChannelsRepository {
  UpdateChannelsRepository({
    required this.reader,
    required this.commands,
    required final ChangeDraft draft,
  }) : _draft = draft {
    if (!commands.owns(reader.store)) {
      throw ArgumentError('Channels store belongs to another connection.');
    }
  }

  final DomainReader<UpdateChannels> reader;
  final ServerCommandCoordinator commands;
  final ChangeDraft _draft;
  final _notices = StreamController<String>.broadcast();

  Stream<String> get notices => _notices.stream;

  CachedValue<UpdateChannels> get value => reader.value;
  Stream<CachedValue<UpdateChannels>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  bool stageChange(final ChangeUpdateChannelJob change) {
    final snapshot = value;
    if (snapshot.support != DomainSupport.supported) {
      return false;
    }
    if (snapshot.data?.currentChannel.id == change.channelId) {
      return _draft.removeWhere(change.replaces);
    }
    if (!(snapshot.data?.channels.any(
          (final channel) => channel.id == change.channelId,
        ) ??
        false)) {
      return false;
    }
    return _draft.add(change);
  }

  void reconcileDraft() {
    final snapshot = value;
    final data = snapshot.data;
    if (data == null ||
        snapshot.freshness != Freshness.fresh ||
        snapshot.lastError != null ||
        snapshot.needsReconciliation) {
      return;
    }
    var removedChannel = false;
    _draft.removeWhere((final change) {
      if (change is! ChangeUpdateChannelJob) {
        return false;
      }
      if (change.channelId == data.currentChannel.id) {
        return true;
      }
      if (!data.channels.any(
        (final channel) => channel.id == change.channelId,
      )) {
        removedChannel = true;
        return true;
      }
      return false;
    });
    if (removedChannel) {
      _notices.add('server.update_channel.removed');
    }
  }

  Future<ServerMutationResult<void>> setChannel(final String channelId) =>
      commands.mutate(
        domains: [reader.store],
        send: (final api) => api.setUpdateChannel(channelId),
      );

  void dispose() => unawaited(_notices.close());
}
