import 'package:family/model/message.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final Message message;
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          margin: const EdgeInsets.only(top: 12.0, right: 15.0, left: 15.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(message.isSender ? 1 : 0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            message.text,
            softWrap: true,
            style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black),
          )),
    );
  }
}
