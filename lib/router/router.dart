import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_page/auth_gath.dart';
import '../tab/home/home_page.dart';
import '../tab/search/srearch_page.dart';
import '../tab/tab_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'login':
        return MaterialPageRoute(builder: (_) => AuthGate());
      case 'search':
        return MaterialPageRoute(builder: (_) => SearchPage());
      case 'tabpage':
        return MaterialPageRoute(builder: (_) => TabPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
