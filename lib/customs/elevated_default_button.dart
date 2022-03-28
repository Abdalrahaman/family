import 'package:family/size_config.dart';
import 'package:flutter/material.dart';

class ElevatedDefaultButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback press;
  const ElevatedDefaultButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: Size(width, height),
      ),
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(fontSize: getProportionateScreenWidth(15)),
      ),
    );
  }
}
