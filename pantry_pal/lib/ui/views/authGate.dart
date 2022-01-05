import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pantry_pal/core/model/user.dart';
import 'package:pantry_pal/core/services/database.dart';
import 'package:pantry_pal/core/services/databaseStreams.dart';
import 'package:pantry_pal/ui/views/loggedIn.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Database _userDB = Database("users");

  @override
  Widget build(BuildContext context) {
    DatabaseStreams _dbStreams = Provider.of<DatabaseStreams>(context);

    return StreamBuilder<User?>(
      stream: _firebaseAuth.authStateChanges(),
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
          String uid = snapshot.data!.uid;
          String name = snapshot.data!.displayName ?? "";
          String email = snapshot.data!.email ?? "";
          DateTime accountCreated = snapshot.data!.metadata.creationTime ?? DateTime.now();

          PantryUser _user = PantryUser.newUser(uid, name, email, accountCreated);

          // check if a new user
          _userDB.checkIfDocExists(uid).then((exists) {
            if (!exists) {
              // new user, add it to db collection
              _userDB.setDocument(uid, _user.toJSON());
            }
          });

          // Render your application if authenticated
          return StreamProvider<PantryUser>.value(
            initialData: _user,
            value: _dbStreams.getCurrentUser(uid),
            child: LoggedIn(),
          );
        }
      },
    );
  }
}
