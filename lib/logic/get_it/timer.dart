import 'package:flutter/material.dart';

class TimerModel extends ChangeNotifier {
  DateTime _time = DateTime.now();

  DateTime get time => _time;

  void restart() {
    _time = DateTime.now();
    notifyListeners();
  }
}
