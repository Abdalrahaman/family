import 'dart:io';

import 'package:family/controllers/client_chat.dart';
import 'package:family/model/socket.dart';

class ClientConnection {
  final List<SocketModel> servers;
  late List<ClientChat> serverSocket = List.empty(growable: true);

  ClientConnection(this.servers);

  Future<List<ClientChat>> connect() async {
    for (SocketModel server in servers) {
      await Socket.connect(server.address, server.port).then((Socket sock) {
        serverSocket.add(ClientChat(sock));
      }).catchError((ex) {
        print('This phone is closed');
      });
    }
    return serverSocket;
  }
}
