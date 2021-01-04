import 'package:flutter/material.dart';
import 'package:pantry_pal/locator.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart';
import 'core/viewmodels/inventory.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<Inventory>(),
          // builder: (_) => )
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        title: 'Pantry Pal',
        onGenerateRoute: UIRouter.generateRoute,
      )
    );
  }
}
