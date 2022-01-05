import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/group.dart';
import 'package:pantry_pal/core/model/user.dart';
import 'package:pantry_pal/core/services/database.dart';
import 'package:provider/provider.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({Key? key}) : super(key: key);

  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _groupIdController = TextEditingController();
  Database _groupDB = Database("groups");
  Database _userDB = Database("users");

  void _joinGroup(BuildContext context, String groupID, PantryUser user) async {
    // check if group exists
    _groupDB.checkIfDocExists(groupID).then((value) async {
      if (value == false) {
        // inform user that that was not a valid group id
        print('no such id found for a group');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Unable to find the group.\nDouble check that you have the right group ID!"),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        print("group exists");
        // add user to group
        var doc = await _groupDB.getDocumentById(groupID);
        Group group = Group.fromMap(doc.data() as Map);

        if (!group.members.contains(user.id)) {
          group.members.add(user.id);
          _groupDB.updateDocument(group.toJSON(), groupID);

          // add group to user's list
          print(user.toJSON());

          user.groupIDs.add(groupID);
          _userDB.updateDocument(user.toJSON(), user.id);

          // push user to home page
          // note: the provider and streams are set up in sign-in and will nav to home automatically
          Navigator.pushReplacementNamed(context, '/sign-in');
        } else {
          // User is already in the group - show snackbar to let them know
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You are already in this group!"),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PantryUser _user = Provider.of<PantryUser>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _groupIdController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.group),
                          hintText: "Group Id",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the item name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "Join",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    print("joining group");
                    if (_formKey.currentState!.validate()) {
                      print("form is valid");
                      _joinGroup(context, _groupIdController.text, _user);
                    }
                    // _joinGroup(context, _groupIdController.text);
                  },
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
