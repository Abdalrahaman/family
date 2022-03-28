import 'package:family/controllers/client_chat.dart';
import 'package:family/providers/host_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceInfoCall extends StatelessWidget {
  final String clientIP;

  const DeviceInfoCall({
    Key? key,
    required this.clientIP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClientChat device = Provider.of<HostProvider>(context, listen: false)
        .devices
        .firstWhere((element) => element.deviceData.deviceIp == clientIP);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50.0,
          backgroundColor: Color(0xFFCFD8DC),
          child: CircleAvatar(
            radius: 45.0,
            backgroundColor: Colors.blue,
            child: Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          device.deviceData.deviceName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(clientIP),
      ],
    );
  }
}
