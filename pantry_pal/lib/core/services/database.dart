import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance; //
  String col = "";
  late CollectionReference ref;

  Database(String collection) {
    this.col = collection;
    this.ref = _db.collection(col);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, Object> data, String id) {
    return ref.doc(id).update(data);
  }
  Future<bool> checkIfDocExists(String id) async {
    try {
      var doc = await ref.doc(id).get();
      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> setDocument(String id, Map data) async {
    try {
      await ref.doc(id).set(data);
    } catch (e) {
      print(e);
    }
  } 
}
