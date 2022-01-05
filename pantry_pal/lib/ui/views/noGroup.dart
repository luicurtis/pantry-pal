import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/user.dart';
import 'package:pantry_pal/ui/views/createGroup.dart';
import 'package:pantry_pal/ui/views/joinGroup.dart';
import 'package:provider/provider.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PantryUser _user = Provider.of<PantryUser>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Welcome to Pantry Pal",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Since you are not in a group yet, you can either " +
                  "to join a group or create a group.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Create"),
                  onPressed: () {
                    print("creating group");
                    print(_user.toJSON());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Provider<PantryUser>.value(
                          value: _user,
                          child: CreateGroup(),
                        ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    print("Joinging Group");
                    print(_user.toJSON());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Provider<PantryUser>.value(
                          value: _user,
                          child: JoinGroup(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
