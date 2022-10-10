import 'package:flutter/material.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/resources/string_manager.dart';

import '../article/article.dart';
import '../main/main_page.dart';
import '../splash/splashView.dart';

class Routes {
  static const String mainRoute = '/main';
  static const String articleRoute = '/article';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.articleRoute:
        return MaterialPageRoute(
            builder: (_) => ArticleView(
                  routeSettings.arguments as ArticleScreen,
                ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
