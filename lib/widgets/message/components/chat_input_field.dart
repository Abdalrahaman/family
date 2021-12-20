import 'package:family/controllers/client_chat.dart';
import 'package:family/model/message.dart';
import 'package:family/providers/chat_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    final _messageController = TextEditingController();
    late String message;
    final client = ModalRoute.of(context)!.settings.arguments as ClientChat;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              color: const Color(0xFF087949).withOpacity(0.08),
            ),
          ]),
      child: SafeArea(
          child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a Message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: Center(
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.white,
                  onPressed: () {
                    message = _messageController.text;
                    Provider.of<ChatMessageProvider>(context, listen: false)
                        .addMessage(Message(message, true));
                    _messageController.clear();
                    client.write(message);
                  },
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
