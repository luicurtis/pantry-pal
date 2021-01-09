import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  final Item item;

  EditItem({this.item});

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int quantity = 0;
  String shelfNum = '';

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit Item Details')),
        actions: [
          FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Item updatedItem = Item(
                    id: widget.item.id,
                    name: name,
                    quantity: quantity,
                    shelfNum: shelfNum,
                    lastUpdated: DateTime.now());
                await itemProvider.updateItem(updatedItem, widget.item.id);
                Navigator.pop(context);
              }
            },
            child: Text('SAVE'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.item.name,
              decoration: InputDecoration(
                hintText: 'Item Name',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the item name';
                }
                return null;
              },
              onSaved: (value) => name = value,
            ),
            TextFormField(
              initialValue: widget.item.quantity.toString(),
              decoration: InputDecoration(
                hintText: 'Number of Items',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              keyboardType: TextInputType.numberWithOptions(signed: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please the number of items';
                }
                return null;
              },
              onSaved: (value) => quantity = int.parse(value),
            ),
            TextFormField(
              initialValue: widget.item.shelfNum,
              decoration: InputDecoration(
                hintText: 'Shelf',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              onSaved: (value) => shelfNum = value,
            ),
          ],
        ),
      ),
    );
  }
}
