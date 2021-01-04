import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/itemDetails.dart';
import 'package:provider/provider.dart';

class ItemPopMenu extends StatelessWidget {
  final Item item;
  final List<String> itemChoices = ['Edit', 'Delete'];
  ItemPopMenu({this.item});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);

    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return itemChoices.map((String choice) {
          return PopupMenuItem<String>(
            child: Text(choice),
            value: choice,
          );
        }).toList();
      },
      onSelected: (choice) async {
        if (choice == 'Edit') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ItemDetails(itemDetails: item)),
          );
        } else if (choice == 'Delete') {
          await itemProvider.removeItem(item.id);
        }
      },
    );
  }
}
