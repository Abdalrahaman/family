import 'package:family/controllers/client_chat.dart';
import 'package:family/size_config.dart';
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
            CircleAvatar(
              backgroundColor: Colors.brown,
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: getSize(18),
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
                Text(
                  _client.deviceData.deviceName,
                  style: TextStyle(fontSize: getSize(16)),
                ),
                Text(
                  _client.socket.remoteAddress.address,
                  style: TextStyle(fontSize: getSize(14)),
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
