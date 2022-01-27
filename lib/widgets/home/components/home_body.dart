import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:family/controllers/client_chat.dart';
import 'package:family/controllers/scan_network.dart';
import 'package:family/controllers/server_connection.dart';
import 'package:family/model/socket.dart';
import 'package:family/providers/host_provider.dart';
import 'package:family/routes.dart';
import 'package:family/widgets/message/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';

import 'device_item_list_view.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ConnectivityResult? result;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  late final ServerConnection _serverConnection;

  late String myIP;
  late List<SocketModel> servers;
  late List<ClientChat> serverSocket;

  @override
  void initState() {
    super.initState();
    _serverConnection = ServerConnection(context, 4567);
    Future.delayed(Duration.zero, () async {
      await initConnectivity();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen((cResult) {
        if (cResult != result) {
          _updateConnectionStatus(cResult);
          result = cResult;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HostProvider>(builder: (context, hostProvider, child) {
      return SafeArea(
        child: ListView.builder(
          itemCount: hostProvider.sockets.length,
          itemBuilder: (context, index) {
            return DeviceItemListView(
              index: index,
              client: hostProvider.sockets[index],
              myIP: myIP,
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: routes[MessageWidget.routeName]!,
                      settings: RouteSettings(
                          arguments: hostProvider.sockets[index]))),
            );
          },
        ),
      );
    });
  }

  Future<void> initConnectivity() async {
    result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result!);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        await getDeviceIP();
        ScanNetwork(context, myIP).getReachiableIP();
        break;
      case ConnectivityResult.mobile:
        await getDeviceIP();
        ScanNetwork(context, '192.168.1').getReachiableIP();
        break;
      case ConnectivityResult.none:
        print('No Internet Connection');
        break;
      default:
    }
  }

  Future<void> getDeviceIP() async {
    myIP = (await NetworkInfo().getWifiIP())!;
    myIP = NumberUtility.changeDigit(myIP, NumStrLanguage.English);
  }
}
