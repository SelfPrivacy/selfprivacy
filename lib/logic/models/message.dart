import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('hh:mm');

class Message {
  Message({this.text, this.type = MessageType.normal}) : time = DateTime.now();

  final String? text;
  final DateTime time;
  final MessageType type;
  String get timeString => formatter.format(time);

  static Message warn({final String? text}) => Message(
        text: text,
        type: MessageType.warning,
      );
}

enum MessageType {
  normal,
  warning,
}
