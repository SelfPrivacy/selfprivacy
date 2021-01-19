import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/message.dart';

class ConsoleModel extends ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    messages.add(message);
    notifyListeners();
  }
}
