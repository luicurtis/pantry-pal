import 'package:flutter/material.dart';
import 'package:pantry_pal/model/item.dart';
import 'package:pantry_pal/pages/edit.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {



  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final Item item = arguments["item"];
    print(item);

    Future editItem() async {
      Item update = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          print(item);
          return EditItem(item: item);
        },
        fullscreenDialog: true
      ));
      if (update != null) {
      // TODO: Will need to refactor to use as the class Item
        // var newItem = {"name":save.name, "shelfNum":save.shelfNum, "quantity":save.quantity};
        setState((){
          // items.add(newItem);
          // print(items);
        });
      }
    } 
    
    return Scaffold(
      appBar: AppBar(title: Text('${item.name}')),
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
            child: Center(child: Text('Last Updated: ${item.lastUpdated}')),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: editItem,
        child: Icon(Icons.edit),
      )
    );
  }
}