import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/takePicture.dart';
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
                if (value.isEmpty) {
                  return 'Please enter the item name';
                }
                return null;
              },
              onSaved: (value) => name = value,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Number of Items',
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
              decoration: InputDecoration(
                hintText: 'Shelf',
                filled: true,
              ),
              textCapitalization: TextCapitalization.sentences,
              onSaved: (value) => shelfNum = value,
            ),
            RaisedButton(
              onPressed: () async {
                // Obtain a list of the available cameras on the device.
                final cameras = await availableCameras();
                // Get a specific camera from the list of available cameras.
                final firstCamera = cameras.first;
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TakePicture(camera: firstCamera),
                  ),
                );
              },
              child: Text('Add Image', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
            ),
            RaisedButton(
              splashColor: Colors.red,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Item newItem = Item(
                      name: name,
                      quantity: quantity,
                      shelfNum: shelfNum,
                      lastUpdated: DateTime.now());
                  await itemProvider.addItem(newItem);
                  Navigator.pop(context);
                }
              },
              child: Text('Done', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
