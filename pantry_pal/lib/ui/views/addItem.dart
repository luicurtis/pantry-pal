import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  String name = 'New Item';
  int quantity = 0;
  String shelfNum = 'N/A';

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              // initialValue: name,
              decoration: InputDecoration(
                hintText: 'Item Name',
                filled: true,
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the item name';
                }
                return null;
              },
              onSaved: (value) => name = value ?? 'New Item',
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Number of Items',
                filled: true,
              ),
              keyboardType: TextInputType.numberWithOptions(signed: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please the number of items';
                }
                return null;
              },
              onSaved: (value) =>
                  quantity = (value != null) ? int.parse(value) : 0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Shelf',
                filled: true,
              ),
              textCapitalization: TextCapitalization.sentences,
              onSaved: (value) => shelfNum = value ?? "N/A",
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Item newItem =
                      Item.noID(name, shelfNum, quantity, DateTime.now());
                  await itemProvider.addItem(newItem);
                  Navigator.pop(context);
                }
              },
              child: Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
