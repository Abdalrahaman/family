import 'package:family/controllers/client_chat.dart';
import 'package:flutter/material.dart';

class DeviceItemListView extends StatelessWidget {
  final int index;
  final ClientChat client;
  final String myIP;
  final VoidCallback press;
  const DeviceItemListView({
    Key? key,
    required this.index,
    required this.client,
    required this.myIP,
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
                const CircleAvatar(
                  radius: 25.0,
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
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Abdelrahman Omran',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          // color: Colors.green,
                          decoration: BoxDecoration(
                            color: const Color(0xFF43A047),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    Text(client.getServerSocket.remoteAddress.address),
                  ],
                ),
              ],
            ),
            ClipOval(
              child: Material(
                child: Ink(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.grey,
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
    client.write('2-$myIP');
  }
}
