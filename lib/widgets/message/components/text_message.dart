import 'package:family/model/message.dart';
import 'package:family/size_config.dart';
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: message.isSender
                ? Color(0xff00838f).withOpacity(0.9)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.text.trim(),
            textAlign: TextAlign.start,
            softWrap: true,
            style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black,
                fontSize: getSize(15)),
          )),
    );
  }
}
