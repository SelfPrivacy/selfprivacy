import 'package:flutter/material.dart';

class TimerModel extends ChangeNotifier {
  DateTime _time = DateTime.now();

  DateTime get messages => _time;

  void restart() {
    _time = DateTime.now();
    notifyListeners();
  }
}
