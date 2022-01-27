import 'package:flutter/material.dart';

class DeviceInfoCall extends StatelessWidget {
  const DeviceInfoCall({
    Key? key,
    required String myIP,
  })  : _myIP = myIP,
        super(key: key);

  final String _myIP;

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'Abdalrahman Omran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(_myIP),
      ],
    );
  }
}
