import 'dart:io';

import 'notification_service.dart';

class ServerConnection {
  final int port;
  late ServerSocket server;
  NotificationService notificationService = NotificationService();
  ServerConnection(this.port) {
    ServerSocket.bind(InternetAddress.anyIPv4, port)
        .then((ServerSocket socket) {
      server = socket;
      server.listen((clientSocket) {
        handleConnection(clientSocket);
      });
    });
  }

  // server send the first welcome message
  void handleConnection(Socket clientSocket) {
    print('Connection from '
        '${clientSocket.remoteAddress.address}:${clientSocket.remotePort}');

    // clients.add(ChatClient(clientSocket));
    // clientSocket.write("Welcome to dart-chat! ");
    // "There are ${clients.length - 1} other clients\n");
    clientSocket.listen(messageHandler);
    clientSocket.write("Welcome to dart-chat! ");
  }

  void messageHandler(List<int> data) {
    String message = String.fromCharCodes(data).trim();
    List<String> parts = message.split(" ");
    if (parts[0] == '1') {
      notificationService.showNotifications(
          int.parse(parts[1]), 'Family', 'This Phone Nearby From Your Home');
    } else {
      print('Client Message: $message');
    }
  }
}
