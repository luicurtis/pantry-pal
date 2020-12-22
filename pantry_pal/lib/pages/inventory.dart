import 'package:flutter/material.dart';

import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/pages/add_entry.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  var items = [
    {"item": "Pasta",
      "quantity": 10,
      "shelfNum": 2 },
    {"item": "Canned Tomatoes",
      "quantity": 5,
      "shelfNum": 3},
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
    {"item": "Pasta",
    "quantity": 10,
    "shelfNum": 2 },
  ];

   Widget buildInventory() {
     return items.length > 0
      ? ListView.separated(
        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text('${items[i]["item"]}'),
            subtitle: Text('Quantity: ${items[i]["quantity"]} \nShelf: ${items[i]["shelfNum"]}'),
            trailing: PopupMenuButton<String>(
              onSelected: (choice) => {
                if (choice == Constants.Edit) {
                  Navigator.pushNamed(context, '/detail', arguments: {"item": items[i]})
                }
                else if (choice == Constants.Delete) {
                  // TODO: Send a delete request to db
                  setState((){
                    items.removeAt(i);
                  })
                }
              },
              itemBuilder: (context) {
                return Constants.ItemChoices.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              },
            ),
            isThreeLine: true,
            // onTap: () {
            //   Navigator.pushNamed(context, '/detail', arguments: {"item": items[i]});
            // },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
      : Center(child: const Text('Add Items!'));
   }

   void addItem() {
     Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return AddEntry();
      },
      fullscreenDialog: true
    ));
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: buildInventory(),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}