import 'package:audioplayers/audioplayers.dart';
import 'package:family/controllers/client_chat.dart';
import 'package:family/controllers/device_info.dart';
import 'package:family/providers/host_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'device_info_call.dart';

class CallBody extends StatefulWidget {
  const CallBody({Key? key}) : super(key: key);

  @override
  State<CallBody> createState() => _CallBodyState();
}

class _CallBodyState extends State<CallBody> {
  AudioCache playerCache = AudioCache(prefix: 'assets/audio/');
  late AudioPlayer player;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _playAudio();
    Future.delayed(const Duration(seconds: 30), () {
      if (_isPlaying) {
        _stopAudio();
        Navigator.pop(context);
      }
    });
  }

  void _playAudio() async {
    player = await playerCache.loop('door_bell.mp3');
    _isPlaying = true;
  }

  void _stopAudio() {
    player.stop();
    _isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    final _clintIP = ModalRoute.of(context)!.settings.arguments as String;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/family.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DeviceInfoCall(
                clientIP: _clintIP,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: Material(
                      child: Ink(
                        width: 70,
                        height: 70,
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              _stopAudio();
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      child: Ink(
                        width: 70,
                        height: 70,
                        decoration: const ShapeDecoration(
                          color: Colors.blue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.done),
                            color: Colors.white,
                            onPressed: () {
                              acceptOpeningDoor(_clintIP);
                              _stopAudio();
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void acceptOpeningDoor(String clintIP) {
    List<ClientChat> _devices =
        Provider.of<HostProvider>(context, listen: false).devices;
    for (ClientChat device in _devices) {
      if (device.socket.remoteAddress.address == clintIP) {
        device.socket.write(
            '1-${_devices.indexOf(device)}-${DeviceInfo.deviceData.deviceName}-Accepted Openning The Door, Please Waiting...');
      }
    }
  }
}
