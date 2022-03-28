import 'package:family/controllers/client_chat.dart';
import 'package:family/controllers/device_info.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DeviceItemListView extends StatelessWidget {
  final ClientChat client;
  final VoidCallback press;
  const DeviceItemListView({
    Key? key,
    required this.client,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: getProportionateScreenWidth(25),
                  backgroundColor: Colors.blue,
                  child: Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(22),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          client.deviceData.deviceName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getSize(16),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(3),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          // color: Colors.green,
                          decoration: BoxDecoration(
                            color: const Color(0xFF43A047),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'New',
                            style: TextStyle(
                                color: Colors.white, fontSize: getSize(10)),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      client.socket.remoteAddress.address,
                      style: TextStyle(fontSize: getSize(14)),
                    ),
                  ],
                ),
              ],
            ),
            ClipOval(
              child: Material(
                child: Ink(
                  width: getProportionateScreenWidth(40),
                  height: getProportionateScreenHeight(40),
                  decoration: ShapeDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: getProportionateScreenWidth(24),
                    ),
                    color: Color(0xFF000000).withOpacity(0.5),
                    onPressed: () => callServer(client),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void callServer(ClientChat client) {
    client.socket.write('2-${DeviceInfo.deviceData.deviceIp}');
  }
}
