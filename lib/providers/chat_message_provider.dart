import 'dart:collection';

import 'package:family/model/message.dart';
import 'package:flutter/material.dart';

class ChatMessageProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
