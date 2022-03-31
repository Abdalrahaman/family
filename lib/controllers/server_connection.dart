import 'dart:convert';
import 'dart:io';

import 'package:family/DB/db.dart';
import 'package:family/controllers/device_info.dart';
import 'package:family/model/device.dart';
import 'package:family/model/message.dart';
import 'package:family/providers/chat_message_provider.dart';
import 'package:family/providers/host_provider.dart';
import 'package:family/widgets/call/call_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import 'notification_service.dart';

class ServerConnection {
  final BuildContext context;
  final int port;
  late ServerSocket server;
  late Socket client;
  NotificationService notificationService = NotificationService();
  ServerConnection(this.context, this.port) {
    ServerSocket.bind(InternetAddress.anyIPv4, port)
        .then((ServerSocket socket) {
      server = socket;
      server.listen((clientSocket) {
        client = clientSocket;
        handleConnection(clientSocket);
      }, onError: errorHandler, onDone: doneHandler);
    });
  }

  // server send the first welcome message
  void handleConnection(Socket clientSocket) {
    print('Connection from '
        '${clientSocket.remoteAddress.address}:${clientSocket.remotePort}');

    clientSocket.listen(messageHandler);
    // send device id and device name to save it in database
    clientSocket.write(
        "3-${DeviceInfo.deviceData.deviceId}-${DeviceInfo.deviceData.deviceName}");
  }

  void messageHandler(List<int> data) async {
    String message = utf8.decode(data);
    List<String> parts = message.split("-");
    switch (parts[0]) {
      case '1':
        notificationService.showNotifications(
            int.parse(parts[1]), parts[2], parts[3]);
        break;
      case '2':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: routes[CallWidget.routeName]!,
              settings: RouteSettings(arguments: parts[1]),
            ));
        break;
      case '3':
        Provider.of<HostProvider>(context, listen: false).addDevice(
            client, Device(parts[1], parts[2], client.remoteAddress.address));
        notificationService.showNotifications(
            1, parts[2], 'Nearby From Your Home');
        await DB().insertDevice(
            Device(parts[1], parts[2], client.remoteAddress.address));
        break;
      case '4':
        Provider.of<HostProvider>(context, listen: false)
            .removeDevice(parts[1]);
        break;
      default:
        Provider.of<ChatMessageProvider>(context, listen: false)
            .addMessage(Message(message, false));
        print('Client Message: $message');
    }
  }

  void errorHandler(error, StackTrace trace) {
    print('server error');
    // Provider.of<HostProvider>(context, listen: false).removeDevice();
  }

  void doneHandler() {
    print('server done');
    // socket.close();
  }
}
