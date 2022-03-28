import 'package:family/model/message.dart';
import 'package:family/size_config.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      margin: EdgeInsets.only(
          left: message.isSender ? getProportionateScreenWidth(100) : 0,
          right: message.isSender ? 0 : getProportionateScreenWidth(100)),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          TextMessage(
            message: message,
          ),
        ],
      ),
    );
  }
}
