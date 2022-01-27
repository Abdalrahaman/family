import 'dart:convert';
import 'dart:io';

import 'package:family/model/message.dart';
import 'package:family/providers/chat_message_provider.dart';
import 'package:family/widgets/call/call_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import 'notification_service.dart';

class ServerConnection {
  final BuildContext context;
  final int port;
  late ServerSocket server;
  NotificationService notificationService = NotificationService();
  ServerConnection(this.context, this.port) {
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

    clientSocket.listen(messageHandler);
    clientSocket.write("Welcome to dart-chat!");
  }

  void messageHandler(List<int> data) {
    String message = utf8.decode(data);
    List<String> parts = message.split("-");
    if (parts[0] == '1') {
      notificationService.showNotifications(
          int.parse(parts[1]), parts[2], parts[3]);
    } else if (parts[0] == '2') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: routes[CallWidget.routeName]!,
              settings: RouteSettings(
                  arguments: parts[1]) //hostProvider.sockets[index]
              ));
    } else {
      Provider.of<ChatMessageProvider>(context, listen: false)
          .addMessage(Message(message, false));
      print('Client Message: $message');
    }
  }
}
