import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/editItem.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ItemDetails extends StatefulWidget {
  final Item itemDetails;

  ItemDetails({this.itemDetails});
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool edited = false;
  Item item;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);
    if (!edited) {
      item = widget.itemDetails;
    }

    var lastUpdatedFormatted =
        new DateFormat.yMMMMd('en_US').add_jm().format(item.lastUpdated);

    return Scaffold(
      appBar: AppBar(
        title: Text('${item.name}'),
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await itemProvider.removeItem(item.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            child: Center(child: Text('Quantity: ${item.quantity}')),
          ),
          Container(
            height: 50,
            child: Center(child: Text('Shelf Number: ${item.shelfNum}')),
          ),
          Container(
            height: 50,
            child: Center(child: Text('Last Updated: $lastUpdatedFormatted')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // TODO: update this function to use async query streams
          Item editedItem = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => EditItem(item: item)));
          if (editedItem != null) {
            setState(() {
              edited = true;
              item = editedItem;
            });
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
