import 'package:intl/intl.dart';

final formater = new DateFormat('hh:mm');

class Message {
  Message({this.text, this.type = MessageType.normal}) : time = DateTime.now();

  final String text;
  final DateTime time;
  final MessageType type;
  String get timeString => formater.format(time);

  static Message warn({String text}) => Message(
        text: text,
        type: MessageType.warning,
      );
}

enum MessageType {
  normal,
  warning,
}
