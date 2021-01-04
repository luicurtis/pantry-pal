import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/addItem':
        return MaterialPageRoute(builder: (_) => AddItem());
      case '/itemDetails':
        return MaterialPageRoute(builder: (_) => ItemDetails());
      case '/editItem':
        return MaterialPageRoute(builder: (_) => EditItem());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('ERROR: No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
