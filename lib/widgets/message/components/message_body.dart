import 'package:family/controllers/client_chat.dart';
import 'package:family/providers/chat_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_input_field.dart';
import 'chat_message.dart';

class MessageBody extends StatefulWidget {
  final ClientChat client;
  const MessageBody({Key? key, required this.client}) : super(key: key);

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMessageProvider>(
        builder: (context, chatMessageProvider, child) {
      if (_scrollController.hasClients) {
        WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      }
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: chatMessageProvider.messages.length,
              itemBuilder: (context, index) => ChatMessage(
                message: chatMessageProvider.messages[index],
              ),
            ),
          ),
          ChatInputField(
            client: widget.client,
          ),
        ],
      );
    });
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
