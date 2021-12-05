import 'package:family/model/socket.dart';
import 'package:family/providers/host_provider.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:provider/provider.dart';

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
      },
    );

    stream.listen((DeviceModel device) {
      if (device.exists &&
          int.parse(device.ip!.substring(device.ip!.lastIndexOf('.') + 1)) !=
              1 &&
          device.ip != myIP) {
        Provider.of<HostProvider>(context, listen: false)
            .addSocket(SocketModel(device.ip!, port));
        print(
            "Found device on ${device.ip}:${device.port}"); // device port is null
      }
    });
  }
}
