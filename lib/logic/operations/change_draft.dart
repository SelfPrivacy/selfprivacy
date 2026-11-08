import 'dart:async';

import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

class ChangeDraft {
  ChangeDraft({required final bool Function() isAttached})
    : _isAttached = isAttached;

  final bool Function() _isAttached;
  final _changes = StreamController<List<JobDraft>>.broadcast(sync: true);
  List<JobDraft> _value = const [];
  bool _disposed = false;
  bool _submitting = false;

  List<JobDraft> get value => _value;
  Stream<List<JobDraft>> get changes => _changes.stream;
  bool get _active => !_disposed && _isAttached();

  bool add(final JobDraft change) {
    if (!_active) {
      return false;
    }
    if (change is ReplaceableJobDraft) {
      _emit([
        ..._value.where((final existing) => !change.replaces(existing)),
        change,
      ]);
    } else {
      if (!change.canAddTo(_value)) {
        return false;
      }
      _emit([..._value, change]);
    }
    return true;
  }

  void remove(final String id) =>
      removeWhere((final change) => change.id == id);

  bool removeWhere(final bool Function(JobDraft) matches) {
    if (!_active) {
      return false;
    }
    final retained = _value.where((final change) => !matches(change)).toList();
    if (retained.length == _value.length) {
      return false;
    }
    _emit(retained);
    return true;
  }

  Future<OperationResult<void>?> apply(
    final Future<OperationResult<void>> Function(List<JobDraft>) submit,
  ) async {
    if (!_active || _submitting || _value.isEmpty) {
      return null;
    }
    _submitting = true;
    final submitted = _value;
    _emit(const []);
    try {
      final result = await submit(submitted);
      if (_active &&
          (result.status == OperationStatus.notSent ||
              result.status == OperationStatus.cancelled)) {
        final newer = _value;
        _emit(submitted);
        newer.forEach(add);
      }
      return result;
    } finally {
      _submitting = false;
    }
  }

  void _emit(final Iterable<JobDraft> changes) {
    _value = List.unmodifiable(changes);
    _changes.add(_value);
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _emit(const []);
    unawaited(_changes.close());
  }
}
