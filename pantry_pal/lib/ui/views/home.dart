import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/addItem.dart';
import 'package:pantry_pal/ui/widgets/itemTile.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> items;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Inventory')),
      ),
      body: Container(
        child: StreamBuilder(
          stream: itemProvider.fetchItemAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              items = snapshot.data.docs
                  .map((doc) => Item.fromMap(doc.data(), doc.id))
                  .toList();

              if (items.length > 0) {
                return ListView.separated(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 48),
                  itemCount: items.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (context, i) => ItemTile(itemDetails: items[i]),
                );
              }
              return Center(child: const Text('Add Items!'));
            } else {
              // TODO: replace this with a loading animation
              return Text('Fetching Inventory');
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
