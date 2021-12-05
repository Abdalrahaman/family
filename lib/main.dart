import 'package:family/providers/host_provider.dart';
import 'package:family/routes.dart';
import 'package:family/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HostProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeWidget.routeName,
      routes: routes,
    );
  }
}
