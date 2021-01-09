import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/editItem.dart';
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
        print(choice);
        print(item);
        if (choice == 'Edit') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditItem(item: item)),
          );
        } else if (choice == 'Delete') {
          print('deleting');
          print(item.id);
          await itemProvider.removeItem(item.id);
        }
      },
    );
  }
}
