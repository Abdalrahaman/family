import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:family/model/device.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static late Device deviceData;

  Future<void> initPlatformState(String deviceName) async {
    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo,
            deviceName, await _getDeviceIP());
      } else {
        if (Platform.isAndroid) {
          deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo,
              deviceName, await _getDeviceIP());
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(
              await deviceInfoPlugin.iosInfo, deviceName, await _getDeviceIP());
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo,
              deviceName, await _getDeviceIP());
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo,
              deviceName, await _getDeviceIP());
        }
      }
    } on PlatformException {}
  }
}

Future<String> _getDeviceIP() async {
  String myIP = (await NetworkInfo().getWifiIP())!;
  myIP = NumberUtility.changeDigit(myIP, NumStrLanguage.English);
  return myIP;
}

Device _readAndroidBuildData(
    AndroidDeviceInfo build, String deviceName, String myIP) {
  return Device(build.androidId!, deviceName, myIP);
}

Device _readIosDeviceInfo(IosDeviceInfo data, String deviceName, String myIP) {
  return Device(data.identifierForVendor!, deviceName, myIP);
}

Device _readLinuxDeviceInfo(
    LinuxDeviceInfo data, String deviceName, String myIP) {
  return Device(data.machineId!, deviceName, myIP);
}

Device _readWebBrowserInfo(
    WebBrowserInfo data, String deviceName, String myIP) {
  return Device(
      data.vendor.toString() +
          data.userAgent.toString() +
          data.hardwareConcurrency.toString(),
      deviceName,
      myIP);
}

Device _readMacOsDeviceInfo(
    MacOsDeviceInfo data, String deviceName, String myIP) {
  return Device(data.systemGUID!, deviceName, myIP);
}
