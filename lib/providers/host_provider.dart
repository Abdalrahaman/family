import 'dart:collection';
import 'dart:io';

import 'package:family/controllers/client_chat.dart';
import 'package:flutter/material.dart';

class HostProvider extends ChangeNotifier {
  final List<ClientChat> _sockets = [];

  UnmodifiableListView<ClientChat> get sockets =>
      UnmodifiableListView(_sockets);

  void addSocket(Socket? socket) {
    if (socket != null &&
        _sockets.indexWhere((element) =>
                element.getServerSocket.remoteAddress.address ==
                socket.remoteAddress.address) ==
            -1) {
      _sockets.add(ClientChat(socket));
    }
    notifyListeners();
  }
}
