import 'package:family/widgets/call/call_widget.dart';
import 'package:family/widgets/home/home_widget.dart';
import 'package:family/widgets/message/message_widget.dart';
import 'package:family/widgets/onboard/onboard_widget.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  OnBoardWidget.routeName: (context) => const OnBoardWidget(),
  HomeWidget.routeName: (context) => const HomeWidget(),
  MessageWidget.routeName: (context) => const MessageWidget(),
  CallWidget.routeName: (context) => const CallWidget(),
};
