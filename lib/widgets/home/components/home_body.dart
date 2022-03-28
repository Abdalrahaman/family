import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:family/controllers/client_chat.dart';
import 'package:family/controllers/device_info.dart';
import 'package:family/controllers/scan_network.dart';
import 'package:family/controllers/server_connection.dart';
import 'package:family/model/socket.dart';
import 'package:family/providers/host_provider.dart';
import 'package:family/routes.dart';
import 'package:family/size_config.dart';
import 'package:family/widgets/message/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SizeConfig().init(context);
    return Consumer<HostProvider>(builder: (context, hostProvider, child) {
      return SafeArea(
        child: hostProvider.devices.isNotEmpty
            ? ListView.builder(
                itemCount: hostProvider.devices.length,
                itemBuilder: (context, index) {
                  return DeviceItemListView(
                    client: hostProvider.devices[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: routes[MessageWidget.routeName]!,
                            settings: RouteSettings(
                                arguments: hostProvider.devices[index]))),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Image.asset('assets/images/empty_home.png'),
                    Text(
                      'Nobody home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
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
    final prefs = await SharedPreferences.getInstance();
    switch (result) {
      case ConnectivityResult.wifi:
        await DeviceInfo().initPlatformState(prefs.getString('deviceName')!);
        await ScanNetwork(context).getReachiableIP();
        break;
      case ConnectivityResult.mobile:
        await DeviceInfo().initPlatformState(prefs.getString('deviceName')!);
        await ScanNetwork(context).getReachiableIP();
        break;
      case ConnectivityResult.none:
        print('No Internet Connection');
        break;
      default:
    }
  }
}
