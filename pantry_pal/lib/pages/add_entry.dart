import 'package:flutter/material.dart';
import 'package:pantry_pal/model/item.dart';

class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
        actions: [
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(Item(name: "test", quantity: 1, shelfNum: 1));},
              child: new Text('SAVE')
          ),
        ],
      ),
      body: new Text("Foo"),
    );
  }
}