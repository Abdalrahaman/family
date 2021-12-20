import 'package:family/providers/chat_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_input_field.dart';
import 'chat_message.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({Key? key}) : super(key: key);

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMessageProvider>(
        builder: (context, chatMessageProvider, child) {
      return Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: chatMessageProvider.messages.length,
                itemBuilder: (context, index) => ChatMessage(
                  message: chatMessageProvider.messages[index],
                ),
              ),
            ),
          ),
          const ChatInputField(),
        ],
      );
    });
  }
}
