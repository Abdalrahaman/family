import 'package:family/widgets/onboard/components/onboard_body.dart';
import 'package:flutter/material.dart';

class OnBoardWidget extends StatelessWidget {
  static String routeName = "/onboard";
  const OnBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardBody(),
    );
  }
}
