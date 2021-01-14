import 'package:flutter/cupertino.dart';
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

Widget slidableTile(
    BuildContext context, Item item, SlidableController slidableController) {
  final itemProvider = Provider.of<Inventory>(context);

  return Slidable(
    key: Key(item.id),
    controller: slidableController,
    child: ItemTile(
      itemDetails: item,
    ),
    actionPane: SlidableDrawerActionPane(),
    actions: <Widget>[
      Column(
        children: [
          Expanded(
            child: IconSlideAction(
              color: Colors.green[300],
              icon: Icons.add,
              onTap: () async {
                Item updatedItem = Item(
                    id: item.id,
                    name: item.name,
                    quantity: (item.quantity + 1),
                    shelfNum: item.shelfNum,
                    lastUpdated: DateTime.now());
                await itemProvider.updateItem(updatedItem, item.id);
                _showSnackBar(context, 'Added 1 ${item.name}');
              },
            ),
          ),
          Expanded(
            child: IconSlideAction(
              color: Colors.red[300],
              icon: Icons.remove,
              onTap: () async {
                Item updatedItem = Item(
                    id: item.id,
                    name: item.name,
                    quantity:
                        ((item.quantity - 1) > 0) ? (item.quantity - 1) : 0,
                    shelfNum: item.shelfNum,
                    lastUpdated: DateTime.now());
                await itemProvider.updateItem(updatedItem, item.id);

                if (updatedItem.quantity > 0) {
                  _showSnackBar(context, 'Removed 1 ${item.name}');
                } else {
                  _showSnackBar(context, 'There is no more ${item.name}');
                }
              },
            ),
          )
        ],
      )
    ],
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Edit',
        color: Colors.black45,
        icon: Icons.edit,
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => EditItem(item: item))),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          return showDialog<bool>(
            context: context,
            builder: (context) {
              return alertDialog(context, itemProvider, item);
            },
          );
        },
      ),
    ],
  );
}
