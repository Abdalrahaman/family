import 'dart:async';
import 'package:family/controllers/device_info.dart';
import 'package:family/controllers/scan_network.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/home_body.dart';

class HomeWidget extends StatefulWidget {
  static String routeName = "/home";

  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String wifiName = 'Family';
  late bool _serviceEnabled;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await checkLocationPermission();
      await networkInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(wifiName),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await DeviceInfo()
                    .initPlatformState(prefs.getString('deviceName')!);
                await ScanNetwork(context).getReachiableIP();
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: const HomeBody(),
    );
  }

  Future<void> networkInfo() async {
    wifiName = (await NetworkInfo().getWifiName())! + ' ' + wifiName;
    setState(() {
      wifiName = wifiName;
    });
  }

  Future<void> checkLocationPermission() async {
    Location location = Location();

    var _permissionGranted = await location.hasPermission();
    _serviceEnabled = await location.serviceEnabled();

    if (_permissionGranted != PermissionStatus.granted || !_serviceEnabled) {
      _permissionGranted = await location.requestPermission();
      _serviceEnabled = await location.requestService();
    }
  }
}
