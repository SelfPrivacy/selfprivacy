import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/message.dart';

class ConsoleModel extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(final Message message) {
    messages.add(message);
    notifyListeners();
    // Make sure we don't have too many messages
    if (messages.length > 500) {
      messages.removeAt(0);
    }
  }
}
