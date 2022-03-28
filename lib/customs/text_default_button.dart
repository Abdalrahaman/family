import 'package:flutter/material.dart';

class TextDefaultButton extends StatelessWidget {
  final String text;
  final double size;
  final VoidCallback press;
  const TextDefaultButton({
    Key? key,
    required this.text,
    required this.size,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize: size),
        ),
        onPressed: press,
        child: Text(text));
  }
}
