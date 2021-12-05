import 'dart:async';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'components/home_body.dart';

class HomeWidget extends StatefulWidget {
  static String routeName = "/home";

  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String wifiName = '';
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await networkInfo();
    });
    // print(myIP);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$wifiName Family'),
      ),
      body: const HomeBody(),
    );
  }

  Future<void> networkInfo() async {
    wifiName = (await NetworkInfo().getWifiName())!;
    setState(() {
      wifiName = wifiName;
    });
  }
}
