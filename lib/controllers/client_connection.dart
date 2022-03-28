import 'dart:convert';
import 'dart:io';

import 'package:family/DB/db.dart';
import 'package:family/controllers/notification_service.dart';
import 'package:family/model/device.dart';
import 'package:family/model/message.dart';
import 'package:family/model/socket.dart';
import 'package:family/providers/chat_message_provider.dart';
import 'package:family/providers/host_provider.dart';
import 'package:family/widgets/call/call_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ClientConnection {
  final BuildContext context;
  final SocketModel server;
  late Socket socket;
  NotificationService notificationService = NotificationService();

  ClientConnection(this.context, this.server);

  Future<void> connect() async {
    await Socket.connect(server.address, server.port).then((Socket sock) {
      socket = sock;
      socket.listen(dataHandler,
          onError: errorHandler, onDone: doneHandler, cancelOnError: false);
      // socket.write(
      //     "3-${DeviceInfo.deviceData.deviceId}-${DeviceInfo.deviceData.deviceName}"); // new
      print('connected');
    }).catchError((ex) {
      print('This phone is closed');
    });
  }

  Future<void> dataHandler(data) async {
    print('Server Message in client connection ${utf8.decode(data)}');
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
            socket, Device(parts[1], parts[2], socket.remoteAddress.address));
        await DB().insertDevice(
            Device(parts[1], parts[2], socket.remoteAddress.address));
        break;
      default:
        Provider.of<ChatMessageProvider>(context, listen: false)
            .addMessage(Message(message, false));
        print('Server Message: $message');
    }
  }

  void errorHandler(error, StackTrace trace) {
    print('client error');
    Provider.of<HostProvider>(context, listen: false).removeAllDevices();
  }

  void doneHandler() {
    print('client done');
    socket.close();
  }
}
