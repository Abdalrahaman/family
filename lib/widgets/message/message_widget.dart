import 'package:family/controllers/client_chat.dart';
import 'package:family/widgets/message/components/message_body.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  static String routeName = "/message";
  const MessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _client = ModalRoute.of(context)!.settings.arguments as ClientChat;
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
              children: [
                const Text(
                  'Abdalrahamn Omran',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _client.getServerSocket.remoteAddress.address,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: MessageBody(
        client: _client,
      ),
    );
  }
}
