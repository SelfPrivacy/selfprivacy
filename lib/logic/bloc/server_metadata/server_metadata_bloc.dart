import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';

part 'server_metadata_event.dart';
part 'server_metadata_state.dart';

class ServerMetadataBloc
    extends Bloc<ServerMetadataEvent, ServerMetadataState> {
  ServerMetadataBloc({
    required final Future<List<ServerMetadataEntity>> Function() loadMetadata,
    required final bool Function() isAttached,
    required final Stream<void> connectionChanges,
    required final void Function() onFailure,
  }) : super(
         isAttached() ? ServerMetadataLoading() : ServerMetadataDetached(),
       ) {
    on<ServerMetadataRequested>((final event, final emit) async {
      if (!isAttached()) {
        return;
      }
      emit(ServerMetadataLoading(metadata: state.metadata));
      try {
        final metadata = await loadMetadata();
        if (!emit.isDone && isAttached()) {
          emit(ServerMetadataLoaded(metadata: metadata));
        }
      } catch (_) {
        if (!emit.isDone && isAttached()) {
          emit(ServerMetadataFailed(metadata: state.metadata));
          onFailure();
        }
      }
    }, transformer: droppable());
    on<_MetadataDetached>((final event, final emit) {
      emit(ServerMetadataDetached());
    });
    _subscription = connectionChanges.listen((_) {
      if (!isAttached()) {
        add(const _MetadataDetached());
      }
    });
    add(const ServerMetadataRequested());
  }

  late final StreamSubscription<void> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
