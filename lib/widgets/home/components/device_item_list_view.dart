import 'package:flutter/material.dart';

class DeviceItemListView extends StatelessWidget {
  final String host;
  const DeviceItemListView({
    Key? key,
    required this.host,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        padding: const EdgeInsets.all(5.0),
                        // color: Colors.yellow,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDD835),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Waiting',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  Text(host),
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
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
