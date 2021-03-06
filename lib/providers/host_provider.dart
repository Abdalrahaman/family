import 'dart:collection';
import 'dart:io';

import 'package:family/controllers/client_chat.dart';
import 'package:family/model/device.dart';
import 'package:flutter/material.dart';

class HostProvider extends ChangeNotifier {
  final List<ClientChat> _devices = [];

  UnmodifiableListView<ClientChat> get devices =>
      UnmodifiableListView(_devices);

  void addDevice(Socket? socket, Device? deviceData) {
    if (socket != null && deviceData != null) {
      _devices.removeWhere(
          (element) => element.deviceData.deviceId == deviceData.deviceId);
      _devices.add(ClientChat(socket, deviceData));
    }
    notifyListeners();
  }

  void removeDevice(String deviceIp) {
    _devices.removeWhere(
        (element) => element.socket.remoteAddress.address == deviceIp);
    notifyListeners();
  }

  void removeAllDevices() {
    _devices.clear();
    notifyListeners();
  }
}
