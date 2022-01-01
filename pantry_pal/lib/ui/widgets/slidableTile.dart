import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/editItem.dart';
import 'package:pantry_pal/ui/widgets/alertDialog.dart';
import 'package:pantry_pal/ui/widgets/itemTile.dart';
import 'package:provider/provider.dart';

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    ),
  );
}

Widget slidableTile(BuildContext context, Item item) {
  final itemProvider = Provider.of<Inventory>(context);

  return Slidable(
    key: Key(item.id),
    child: ItemTile(
      itemDetails: item,
    ),
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.25,
      children: [
        Expanded(
          child: Column(
            children: [
              SlidableAction(
                backgroundColor: Colors.green.shade300,
                icon: Icons.add,
                onPressed: (context) async {
                  Item updatedItem = Item(item.id, item.name, item.shelfNum,
                      (item.quantity + 1), DateTime.now());
                  await itemProvider.updateItem(updatedItem, item.id);
                  _showSnackBar(context, 'Added 1 ${item.name}');
                },
              ),
              SlidableAction(
                backgroundColor: Colors.red.shade300,
                icon: Icons.remove,
                onPressed: (context) async {
                  int numItem =
                      ((item.quantity - 1) > 0) ? (item.quantity - 1) : 0;

                  Item updatedItem = Item(item.id, item.name, item.shelfNum,
                      numItem, DateTime.now());

                  await itemProvider.updateItem(updatedItem, item.id);

                  if (updatedItem.quantity > 0) {
                    _showSnackBar(context, 'Removed 1 ${item.name}');
                  } else {
                    _showSnackBar(context, 'There is no more ${item.name}');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: ScrollMotion(),
      extentRatio: 0.5,
      children: [
        SlidableAction(
          label: 'Edit',
          backgroundColor: Colors.black45,
          icon: Icons.edit,
          onPressed: (context) => Navigator.push(
              context, MaterialPageRoute(builder: (_) => EditItem(item: item))),
        ),
        SlidableAction(
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (context) {
            showDialog<bool>(
              context: context,
              builder: (context) {
                return alertDialog(context, itemProvider, item);
              },
            );
          },
        ),
      ],
    ),
  );
}
