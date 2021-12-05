import 'dart:collection';

import 'package:family/model/socket.dart';
import 'package:flutter/material.dart';

class HostProvider extends ChangeNotifier {
  final List<SocketModel> _sockets = [];

  UnmodifiableListView<SocketModel> get sockets =>
      UnmodifiableListView(_sockets);

  void addSocket(SocketModel? socket) {
    if (_sockets.indexWhere((element) => element.address == socket!.address) ==
        -1) {
      _sockets.add(socket!);
    }
    notifyListeners();
  }
}
