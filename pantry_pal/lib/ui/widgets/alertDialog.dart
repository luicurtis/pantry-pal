import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';

Widget alertDialog(BuildContext context, Inventory itemProvider, Item item) {
  return AlertDialog(
    title: Text('Delete'),
    content: Text('${item.name} will be deleted'),
    actions: <Widget>[
      FlatButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      FlatButton(
        child: Text('Ok'),
        onPressed: () {
          itemProvider.removeItem(item.id);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      )
    ],
  );
}
