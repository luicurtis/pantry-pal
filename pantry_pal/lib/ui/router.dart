import 'package:flutter/material.dart';
import 'package:pantry_pal/ui/views/addItem.dart';
import 'package:pantry_pal/ui/views/home.dart';
import 'package:pantry_pal/ui/views/authGate.dart';
import 'package:pantry_pal/ui/views/loggedIn.dart';

class UIRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthGate());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => AuthGate());
      case '/addItem':
        return MaterialPageRoute(builder: (_) => AddItem());
      case '/logged-in':
        return MaterialPageRoute(builder: (_) => LoggedIn());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('ERROR: No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
