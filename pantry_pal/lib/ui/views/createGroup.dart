import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/group.dart';
import 'package:pantry_pal/core/model/user.dart';
import 'package:pantry_pal/core/services/database.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  // final String uid = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController _groupNameController = TextEditingController();
  Database _groupDB = Database("groups");
  Database _userDB = Database("users");

  void _createGroup(
      BuildContext context, String groupName, PantryUser creator) async {
    Group newGroup = Group.newGroup(
      groupName,
      creator.id,
      [creator.id],
      DateTime.now(),
    );

    DocumentReference groupDoc = await _groupDB.addDocument(newGroup.toJSON());
    print("Group ID Created: " + groupDoc.id);
    // add group id to newly created group
    newGroup.setID(groupDoc.id);
    print(newGroup.toJSON());
    await _groupDB.updateDocument(newGroup.toJSON(), newGroup.id);

    // add group id to creator's list
    creator.addGroupID(groupDoc.id);
    print(creator.toJSON());
    await _userDB.updateDocument(creator.toJSON(), creator.id);

    // push user to home page 
    // note: the provider and streams are set up in sign-in and will nav to home automatically
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    PantryUser _user = Provider.of<PantryUser>(context);

    return Scaffold(
      body: Column(
        children: [
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
              children: <Widget>[
                TextFormField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.group),
                    hintText: "Group Name",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Create Group",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Add validation for textfield
                      print("Creating group button pressed");
                      print(_user.toJSON());

                      _createGroup(context, _groupNameController.text, _user);
                    }
                    // _goToAddBook(context, _groupNameController.text),
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
