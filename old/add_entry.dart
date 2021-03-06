import 'package:flutter/material.dart';
import 'package:pantry_pal/model/item.dart';
import 'package:numberpicker/numberpicker.dart';


class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  DateTime curDateTime = DateTime.now();
  String name = "New Item";
  int shelfNum = 0;
  int quantity = 0;
  String note = "";

  var _controller = TextEditingController();

  void showShelfPicker(BuildContext context) {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          initialIntegerValue: shelfNum, 
          minValue: 0, 
          maxValue: 10,
          title: Text('Pick the shelf number')
        );
      }  
    ).then((value) => {
      if (value != null) {
        setState(() { 
          shelfNum = value;
          print(name);
        })
      }
    });
  }

  void showQuantityPicker(BuildContext context) {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          initialIntegerValue: quantity, 
          minValue: 0, 
          maxValue: 100,
          title: Text('Number of $name')
        );
      }  
    ).then((value) => {
      if (value != null) {
        setState(() => quantity = value)
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New entry'),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop(
                  Item(name: name, quantity: quantity, shelfNum: shelfNum, lastUpdated: curDateTime)
                );},
              child: Text('SAVE')
          ),
        ],
      ),
      body: Column(children: [
        ListTile (
          leading: Icon(Icons.speaker_notes),
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Item Name',
              suffixIcon: IconButton(
                onPressed: () => _controller.clear(),
                icon: Icon(Icons.clear),
              ),
            ),
            controller: _controller,
            onChanged: (value) => name = value,
          )
        ),
        ListTile(
          leading: Icon(Icons.list_rounded),
          title: Text('$shelfNum'),
          onTap: () => showShelfPicker(context),
        ),
        ListTile(
          leading: Icon(Icons.list_rounded),
          title: Text('$quantity'),
          onTap: () => showQuantityPicker(context),
        ),
        ListTile(
          leading: Icon(Icons.notes),
          title: TextField(
            decoration: InputDecoration(hintText: 'Optional Note'),
            controller: TextEditingController(text: note),
            onChanged: (value) => note = value,
          ),
        )
      ]),
    );
  }
}
