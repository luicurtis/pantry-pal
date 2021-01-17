import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/addItem.dart';
import 'package:pantry_pal/ui/views/search.dart';
import 'package:pantry_pal/ui/widgets/fetchingInventoryAnimation.dart';
import 'package:pantry_pal/ui/widgets/slidableTile.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SlidableController slidableController = SlidableController();
  List<Item> items;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inventory'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(context));
            },
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: itemProvider.fetchItemAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              items = snapshot.data.docs
                  .map((doc) => Item.fromMap(doc.data(), doc.id))
                  .toList();
              items.sort((a, b) =>
                  a.name.toLowerCase().compareTo(b.name.toLowerCase()));

              if (items.length > 0) {
                return ListView.separated(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 48),
                  itemCount: items.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (context, i) {
                    return slidableTile(context, items[i], slidableController);
                  },
                );
              }
              return Center(child: const Text('Add Items!'));
            } else {
              return fetchingInventoryAnimation();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddItem()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
