import 'package:intl/intl.dart';

final formater = new DateFormat('hh:mm');

class Message {
  Message({
    this.text,
  }) : time = DateTime.now();

  final String text;
  final DateTime time;

  String get timeString => formater.format(time);
}
