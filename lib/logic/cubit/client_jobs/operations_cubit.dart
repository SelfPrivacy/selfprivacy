import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

class OperationsState extends Equatable {
  OperationsState({
    required final Iterable<OperationSnapshot> operations,
    final Set<int> removing = const {},
    this.focusId,
  }) : operations = List.unmodifiable(operations),
       removing = Set.unmodifiable(removing);

  final List<OperationSnapshot> operations;
  final Set<int> removing;
  final int? focusId;

  @override
  List<Object?> get props => [operations, removing, focusId];
}

class OperationsCubit extends Cubit<OperationsState> {
  OperationsCubit({
    required final OperationQueue queue,
    required final Future<bool> Function(int) remove,
    required final void Function(String) showMessage,
  }) : _queue = queue,
       _remove = remove,
       _showMessage = showMessage,
       super(OperationsState(operations: queue.history.where(_visible))) {
    _opened.addAll(queue.history.map((final operation) => operation.id));
    _subscription = queue.changes.listen((final history) {
      var focusId = state.focusId;
      for (final operation in history.where(_visible)) {
        if (_longOperation(operation) && _opened.add(operation.id)) {
          focusId = operation.id;
        }
      }
      _opened.retainAll(history.map((final operation) => operation.id));
      emit(
        OperationsState(
          operations: history.where(_visible),
          removing: state.removing,
          focusId: focusId,
        ),
      );
    });
  }

  final OperationQueue _queue;
  final Future<bool> Function(int) _remove;
  final void Function(String) _showMessage;
  final _opened = <int>{};
  late final StreamSubscription<List<OperationSnapshot>> _subscription;
  bool sheetOpen = false;

  static bool _visible(final OperationSnapshot operation) =>
      operation.kind != OperationKind.manageJobs;
  static bool _longOperation(final OperationSnapshot operation) =>
      switch (operation.kind) {
        OperationKind.createBackups ||
        OperationKind.restoreBackup ||
        OperationKind.moveServices ||
        OperationKind.migrateVolumes ||
        OperationKind.applyChanges ||
        OperationKind.rebootServer ||
        OperationKind.upgradeServer ||
        OperationKind.collectGarbage ||
        OperationKind.initializeBackups ||
        OperationKind.removeBackups ||
        OperationKind.resizeVolume => true,
        _ => false,
      };

  void cancel(final int id) => _queue.cancel(id);

  Future<void> remove(final int id) async {
    if (state.removing.contains(id)) {
      return;
    }
    emit(
      OperationsState(
        operations: state.operations,
        removing: {...state.removing, id},
        focusId: state.focusId,
      ),
    );
    var removed = false;
    try {
      removed = await _remove(id);
    } catch (_) {
      removed = false;
    }
    if (isClosed) {
      return;
    }
    emit(
      OperationsState(
        operations: _queue.history.where(_visible),
        removing: {...state.removing}..remove(id),
        focusId: state.focusId,
      ),
    );
    if (!removed) {
      _showMessage('operations.cleanup_failed'.tr());
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
