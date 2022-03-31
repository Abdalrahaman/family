import 'package:family/model/message.dart';
import 'package:family/size_config.dart';
import 'package:family/values/colors.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color:
                message.isSender ? fPrimaryColor : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.text.trim(),
            textDirection: TextDirection.rtl,
            softWrap: true,
            style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black,
                fontSize: getSize(15.5)),
          )),
    );
  }
}
