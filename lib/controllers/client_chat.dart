import 'dart:convert';
import 'dart:io';

import 'package:family/model/device.dart';

class ClientChat {
  final Socket socket;
  final Device deviceData;

  ClientChat(this.socket, this.deviceData);

  void write(String message) {
    socket.add(utf8.encode(message));
  }
}
