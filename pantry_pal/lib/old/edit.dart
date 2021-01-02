import 'package:flutter/material.dart';
import 'package:pantry_pal/model/item.dart';
import 'package:numberpicker/numberpicker.dart';


class EditItem extends StatefulWidget {
  final Item item;
  EditItem({this.item});

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  // print(widget.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Editing Item'),
      ),
      body: Column(
        children: [
          ListTile(
          ),
        ],
      ),
    );
  }
}