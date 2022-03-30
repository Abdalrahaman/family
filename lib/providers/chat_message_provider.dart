import 'dart:collection';

import 'package:family/model/message.dart';
import 'package:flutter/material.dart';

class ChatMessageProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  String text = "";

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);

  void addMessage(Message message) {
    if (message.text.isNotEmpty) {
      _messages.add(message);
    }
    notifyListeners();
  }

  void updateTextField(String msg) {
    text = msg;
  }
}
