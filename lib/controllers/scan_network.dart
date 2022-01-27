import 'dart:io';

import 'package:family/controllers/client_connection.dart';
import 'package:family/model/socket.dart';
import 'package:family/providers/host_provider.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:provider/provider.dart';

import 'client_chat.dart';

class ScanNetwork {
  final BuildContext context;
  final String myIP;

  ScanNetwork(this.context, this.myIP);

  Future<void> getReachiableIP() async {
    final scanner = LanScanner();
    String subnet = myIP.substring(0, myIP.lastIndexOf('.'));
    int port = 4567;

    final stream = scanner.preciseScan(
      subnet,
      firstIP: 1,
      lastIP: 15,
      progressCallback: (ProgressModel progress) {
        print('${progress.percent * 100}% 192.168.1.${progress.currIP}');
        if (progress.percent == 1.0) {
          sendNotificationForAllDevices(
              Provider.of<HostProvider>(context, listen: false).sockets);
        }
      },
    );

    stream.listen((DeviceModel device) async {
      if (device.exists &&
          int.parse(device.ip!.substring(device.ip!.lastIndexOf('.') + 1)) !=
              1 &&
          device.ip != myIP) {
        print(
            "Found device on ${device.ip}:${device.port}"); // device port is null
        ClientConnection _clientConnection =
            ClientConnection(SocketModel(device.ip!, port));
        Socket? serverSocket = await _clientConnection.connect();
        Provider.of<HostProvider>(context, listen: false)
            .addSocket(serverSocket);
      }
    });
  }

  void sendNotificationForAllDevices(List<ClientChat> serverSocket) {
    for (ClientChat client in serverSocket) {
      client.write(
          '1-${serverSocket.indexOf(client)}-Family-This Phone Nearby From Your Home');
    }
  }
}
