import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/message.dart';

abstract class ConsoleModel extends ChangeNotifier {
  void addMessage(Message message);

  List<Message> get messages;
}

class ConsoleModelImplementation extends ConsoleModel {
  List<Message> _messages = [];

  @override
  List<Message> get messages => _messages;

  @override
  void addMessage(Message message) {
    messages.add(message);
    notifyListeners();
  }
}
