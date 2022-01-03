import 'package:flutter/material.dart';
import 'package:pantry_pal/ui/views/addItem.dart';
import 'package:pantry_pal/ui/views/home.dart';
import 'package:pantry_pal/ui/widgets/authGate.dart';

// FIXME: Not sure if this is being used or not .. needs more investigation
class UIRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => AuthGate());
      case '/addItem':
        return MaterialPageRoute(builder: (_) => AddItem());
      // Path not used
      // case '/itemDetails':
      //   return MaterialPageRoute(builder: (_) => ItemDetails(itemDetails: null,));
      // case '/editItem':
      //   return MaterialPageRoute(builder: (_) => EditItem());
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
