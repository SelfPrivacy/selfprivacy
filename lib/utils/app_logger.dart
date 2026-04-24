import 'dart:developer' as developer;

import 'package:selfprivacy/config/config.dart';

class AppLogger {
  const AppLogger({required this.name});

  final String name;

  // TODO(Aliaksei): research other possible options, which could support both
  // throttling and output formatting
  void log(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  }) {
    if (config.shouldDebugPrint) {
      // TODO(Aliaksei): could probably add UI logging for console_page
      developer.log(
        message,
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
        name: name,
      );
    }
  }
}
