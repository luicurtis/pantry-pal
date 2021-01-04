import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/locator.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart';
import 'core/viewmodels/inventory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
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
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        title: 'Pantry Pal',
        theme: ThemeData(),
        onGenerateRoute: UIRouter.generateRoute,
      )
    );
  }
}
