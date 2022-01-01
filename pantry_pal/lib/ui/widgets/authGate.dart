import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pantry_pal/ui/views/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
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
                  action == AuthAction.signIn
                      ? 'Welcome to Pantry Pal! Please sign in to continue.'
                      : 'Fill in the details below to create an account',
                ),
              );
            },
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    'Enjoy!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
            providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId: "1:618061069876:android:6ce82458f00844fd099461"),
            ],
          );
        }

        // Render your application if authenticated
        return Home();
      },
    );
  }
}
