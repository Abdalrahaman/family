import 'package:family/model/message.dart';
import 'package:flutter/material.dart';

import 'text_message.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  const ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        TextMessage(
          message: message,
        ),
      ],
    );
  }
}
