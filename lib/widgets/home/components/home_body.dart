import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:family/controllers/client_chat.dart';
import 'package:family/controllers/client_connection.dart';
import 'package:family/controllers/scan_network.dart';
import 'package:family/controllers/server_connection.dart';
import 'package:family/model/socket.dart';
import 'package:family/providers/host_provider.dart';
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

  final ServerConnection _serverConnection = ServerConnection(4567);

  late String myIP;
  late List<SocketModel> servers;
  late List<ClientChat> serverSocket;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      myIP = (await NetworkInfo().getWifiIP())!;
      myIP = NumberUtility.changeDigit(myIP, NumStrLanguage.English);
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
              host: hostProvider.sockets[index].address,
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
        ScanNetwork(context, myIP).getReachiableIP();
        await Future.delayed(const Duration(seconds: 45), () {
          servers = Provider.of<HostProvider>(context, listen: false).sockets;
        });
        ClientConnection _clientConnection = ClientConnection(servers);
        serverSocket = await _clientConnection.connect();
        for (ClientChat client in serverSocket) {
          client.write('1 ${serverSocket.indexOf(client)}');
        }
        break;
      case ConnectivityResult.mobile:
        ScanNetwork(context, '192.168.1').getReachiableIP();
        break;
      case ConnectivityResult.none:
        print('No Internet Connection');
        break;
      default:
    }
  }
}
