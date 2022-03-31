import 'package:family/DB/db.dart';
import 'package:family/controllers/client_connection.dart';
import 'package:family/controllers/device_info.dart';
import 'package:family/model/socket.dart';
import 'package:family/providers/host_provider.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:provider/provider.dart';

import 'client_chat.dart';

class ScanNetwork {
  final BuildContext context;

  ScanNetwork(this.context);

  Future<void> getReachiableIP() async {
    final scanner = LanScanner();
    String subnet = DeviceInfo.deviceData.deviceIp
        .substring(0, DeviceInfo.deviceData.deviceIp.lastIndexOf('.'));
    int port = 4567;

    final stream = scanner.icmpScan(
      subnet,
      firstIP: 1,
      lastIP: 15,
      progressCallback: (progress) async {
        print(progress);
        if (progress == 1.0) {
          sendNotificationForAllDevices(
              Provider.of<HostProvider>(context, listen: false).devices);
          print(await DB().getDevices());
        }
      },
    );

    stream.listen((HostModel device) async {
      if (device.isReachable &&
          int.parse(device.ip.substring(device.ip.lastIndexOf('.') + 1)) != 1 &&
          device.ip != DeviceInfo.deviceData.deviceIp) {
        print("Found device on ${device.ip}");
        ClientConnection _clientConnection =
            ClientConnection(context, SocketModel(device.ip, port));
        await _clientConnection.connect();
      }
    });
  }

  void sendNotificationForAllDevices(List<ClientChat> devices) {
    for (ClientChat device in devices) {
      device.socket.write(
          '3-${DeviceInfo.deviceData.deviceId}-${DeviceInfo.deviceData.deviceName}');
    }
  }
}
