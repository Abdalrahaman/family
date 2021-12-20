import 'dart:io';

import 'package:family/model/socket.dart';

class ClientConnection {
  final SocketModel server;
  Socket? socket;

  ClientConnection(this.server);

  Future<Socket?> connect() async {
    await Socket.connect(server.address, server.port).then((Socket sock) {
      socket = sock;
      print('connected');
    }).catchError((ex) {
      print('This phone is closed');
    });
    return socket;
  }
}
