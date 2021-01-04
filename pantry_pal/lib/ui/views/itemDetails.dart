import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/editItem.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatelessWidget {
  final Item itemDetails;

  ItemDetails({this.itemDetails});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${itemDetails.name}'),
        actions: [
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await itemProvider.removeItem(itemDetails.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            child: Center(child: Text('Quantity: ${itemDetails.quantity}')),
          ),
          Container(
            height: 50,
            child: Center(child: Text('Shelf Number: ${itemDetails.shelfNum}')),
          ),
          Container(
            height: 50,
            child:
                Center(child: Text('Last Updated: ${itemDetails.lastUpdated}')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => EditItem(item: itemDetails)));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
