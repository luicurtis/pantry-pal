import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pantry_pal/ui/views/home.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: [
              // FIXME: currently doesnt support all emails https://github.com/FirebaseExtended/flutterfire/discussions/6978
              // EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId: "1:618061069876:android:6ce82458f00844fd099461"),
            ],
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                      'https://firebase.flutter.dev/img/flutterfire_300x.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                      'Welcome to Pantry Pal!\nPlease sign in with Google to continue.')
                  // child: Text(
                  //   action == AuthAction.signIn
                  //       ? 'Welcome to Pantry Pal! Please sign in to continue.'
                  //       : 'Fill in the details below to create an account',
                  // ),
                  );
            },
            showAuthActionSwitch: false,
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    'Thank you and Enjoy!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );
        } else {
          // Render your application if authenticated
          // Navigator.pushReplacementNamed(context, '/sign-in');
          return Home();
        }
      },
    );
  }
}
