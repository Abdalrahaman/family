import 'package:family/providers/chat_message_provider.dart';
import 'package:family/providers/host_provider.dart';
import 'package:family/routes.dart';
import 'package:family/values/styles.dart';
import 'package:family/widgets/home/home_widget.dart';
import 'package:family/widgets/onboard/onboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/notification_service.dart';

bool? _isCreated;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  _isCreated = prefs.getBool('onBoardCreated');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HostProvider()),
      ChangeNotifierProvider(create: (_) => ChatMessageProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: fMainTheme,
      initialRoute: _isCreated == null || !_isCreated!
          ? OnBoardWidget.routeName
          : HomeWidget.routeName,
      routes: routes,
    );
  }
}
