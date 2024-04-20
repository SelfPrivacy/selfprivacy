import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/console_log.dart';

class ConsoleModel extends ChangeNotifier {
  final List<ConsoleLog> _logs = [];
  List<ConsoleLog> get logs => _logs;

  void log(final ConsoleLog newLog) {
    logs.add(newLog);
    notifyListeners();
    // Make sure we don't have too many
    if (logs.length > 500) {
      logs.removeAt(0);
    }
  }
}
