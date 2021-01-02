import 'package:flutter/material.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/pages/add_entry.dart';
import 'package:pantry_pal/model/item.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  // TODO: Will need to refactor to use as the class Item
  Item pasta = Item(name: "pasta", shelfNum: 4, quantity: 5, lastUpdated:DateTime.now());
  // static var items = [
  //   {"name": "Pasta",
  //     "quantity": 10,
  //     "shelfNum": 2 },
  //   {"name": "Canned Tomatoes",
  //     "quantity": 5,
  //     "shelfNum": 3},
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  //   {"name": "Pasta",
  //   "quantity": 10,
  //   "shelfNum": 2 },
  // ];
  static var items = [
    // Item(name: "pasta", shelfNum: 4, quantity: 5, lastUpdated:DateTime.now()),
    // Item(name: "pasta", shelfNum: 4, quantity: 5, lastUpdated:DateTime.now()),
    // Item(name: "pasta", shelfNum: 4, quantity: 5, lastUpdated:DateTime.now())
  ];

   Widget buildInventory() {
     return items.length > 0
      ? ListView.separated(
        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text('${items[i].name}'),
            subtitle: Text('Quantity: ${items[i].quantity} \nShelf: ${items[i].shelfNum}'),
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
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: {"item": items[i]});
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
      : Center(child: const Text('Add Items!'));
   }

   Future addItem() async {
    Item save = await Navigator.of(context).push(new MaterialPageRoute<Item>(
      builder: (BuildContext context) {
        return AddEntry();
      },
      fullscreenDialog: true
    ));
    if (save != null) {
    // TODO: Will need to refactor to use as the class Item
      // var newItem = {"name":save.name, "shelfNum":save.shelfNum, "quantity":save.quantity, "lastUpdated":save.lastUpdated};
      setState((){
        items.add(save);
        print(items);
      });
    }
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