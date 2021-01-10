import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/ui/views/itemDetails.dart';
// import 'package:pantry_pal/ui/widgets/itemPopmenu.dart';

class ItemTile extends StatelessWidget {
  final Item itemDetails;

  ItemTile({this.itemDetails});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${itemDetails.name}'),
      subtitle: Text(
        'Quantity: ${itemDetails.quantity}\nShelf: ${itemDetails.shelfNum}',
      ),
      isThreeLine: true,
      // trailing: ItemPopMenu(item: itemDetails),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemDetails(itemDetails: itemDetails),
          ),
        );
      },
    );
  }
}
