import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/group.dart';
import 'package:pantry_pal/core/model/user.dart';
import 'package:pantry_pal/core/services/databaseStreams.dart';
import 'package:pantry_pal/ui/views/noGroup.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class LoggedIn extends StatelessWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseStreams _dbStreams = Provider.of<DatabaseStreams>(context);
    PantryUser _user = Provider.of<PantryUser>(context);

    print(_user.toJSON());

    // if the current user is in a group, show home
    if (_user.groupIDs.length > 0) {
      print("user has a group");
      return StreamProvider<Group>.value(
        initialData: Group(),
        value: _dbStreams.getCurrentGroup(_user.groupIDs[0]),
        child: Home(),
      );
    } else {
      // show group creation/join page if not in a group already
      return NoGroup();
    }
  }
}
