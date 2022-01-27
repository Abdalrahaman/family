import 'package:family/widgets/call/components/call_body.dart';
import 'package:flutter/material.dart';

class CallWidget extends StatelessWidget {
  static String routeName = "/call";
  const CallWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CallBody(),
    );
  }
}
