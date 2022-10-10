import 'package:flutter/material.dart';
import 'package:news_watch/presentation/resources/routes_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.mainRoute,
      theme: getApplicationTheme(),
    );
  }
}
