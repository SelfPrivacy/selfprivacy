import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/console_log.dart';

class ConsoleModel extends ChangeNotifier {
  /// limit for history, so logs won't affect memory and overflow
  static const logBufferLimit = 500;

  /// differs from log buffer limit so as to not rearrange memory each time
  /// we add incoming log
  static const incomingBufferBreakpoint = 750;

  final List<ConsoleLog> _logs = [];
  final List<ConsoleLog> _incomingQueue = [];

  bool _paused = false;
  bool get paused => _paused;
  List<ConsoleLog> get logs => _logs;

  void log(final ConsoleLog newLog) {
    if (paused) {
      _incomingQueue.add(newLog);
      if (_incomingQueue.length > incomingBufferBreakpoint) {
        _incomingQueue.removeRange(0, _incomingQueue.length - logBufferLimit);
      }
    } else {
      logs.add(newLog);
      _updateQueue();
    }
  }

  void play() {
    _logs.addAll(_incomingQueue);
    _paused = false;
    _updateQueue();
    _incomingQueue.clear();
  }

  void pause() {
    _paused = true;
    notifyListeners();
  }

  /// drop logs over the limit and
  void _updateQueue() {
    // Make sure we don't have too many
    if (logs.length > logBufferLimit) {
      logs.removeRange(0, logs.length - logBufferLimit);
    }
    notifyListeners();
  }
}
