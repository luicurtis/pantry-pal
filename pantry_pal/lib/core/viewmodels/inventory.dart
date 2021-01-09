import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/services/database.dart';
import 'package:pantry_pal/locator.dart';

class Inventory extends ChangeNotifier {
  Database _db = locator<Database>();
  List<Item> items;

  Future<List<Item>> fetchItems() async {
    var result = await _db.getDataCollection();
    // for each doc, map it to an Item class
    items = result.docs.map((doc) => Item.fromMap(doc.data(), doc.id)).toList();
    return items;
  }

  Stream<QuerySnapshot> fetchItemAsStream() {
    return _db.streamDataCollection();
  }

  Future<Item> getItemById(String id) async {
    var doc = await _db.getDocumentById(id);
    return Item.fromMap(doc.data(), doc.id);
  }

  Future removeItem(String id) async {
    await _db.removeDocument(id);
    return;
  }

  Future updateItem(Item data, String id) async {
    await _db.updateDocument(data.toJSON(), id);
    return;
  }

  Future addItem(Item data) async {
    var docRef = await _db.addDocument(data.toJSON());
    data.id = docRef.id;
    await _db.updateDocument(data.toJSON(), docRef.id);
    // TODO: Check result
    return;
  }
}
