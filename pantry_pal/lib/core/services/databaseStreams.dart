import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantry_pal/core/model/group.dart';
import 'package:pantry_pal/core/model/user.dart';

class DatabaseStreams {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<PantryUser> getCurrentUser(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => PantryUser.fromMap(doc.data() as Map));
  }

  Stream<Group> getCurrentGroup(String uid) {
    return _db
        .collection('groups')
        .doc(uid)
        .snapshots()
        .map((snapshot) => Group.fromMap(snapshot as Map));
  }
}
