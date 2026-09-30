import 'dart:async';

import 'package:flutter/widgets.dart';

class AppLifecycle with WidgetsBindingObserver {
  AppLifecycle({final WidgetsBinding? binding})
    : _binding = binding ?? WidgetsBinding.instance {
    _isForeground = _isVisible(_binding.lifecycleState);
    _binding.addObserver(this);
  }

  final WidgetsBinding _binding;
  final _changes = StreamController<bool>.broadcast(sync: true);
  late bool _isForeground;
  bool _disposed = false;

  bool get isForeground => _isForeground;

  Stream<bool> get foregroundChanges => _changes.stream;

  static bool _isVisible(final AppLifecycleState? state) =>
      state == AppLifecycleState.resumed || state == AppLifecycleState.inactive;

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (_disposed) {
      return;
    }
    final foreground = _isVisible(state);
    if (foreground != _isForeground) {
      _isForeground = foreground;
      _changes.add(foreground);
    }
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _binding.removeObserver(this);
    unawaited(_changes.close());
  }
}
