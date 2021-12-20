import 'package:family/widgets/message/components/message_body.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  static String routeName = "/message";
  const MessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.brown,
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
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Abdalrahamn Omran',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '192.168.1.5',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const MessageBody(),
    );
  }
}
