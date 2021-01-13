import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/ui/widgets/itemTile.dart';

Widget slidableTile(BuildContext context, Item item) {
  return Slidable(
    key: Key(item.id),
    child: ItemTile(
      itemDetails: item,
    ),
    actionPane: SlidableDrawerActionPane(),
    actions: <Widget>[
      Column(
        children: [
          Expanded(
            child: IconSlideAction(
                // caption: '- 1',
                color: Colors.green[200],
                icon: Icons.add
                // onTap: () => _showSnackBar('Share'),
                ),
          ),
          Expanded(
            child: IconSlideAction(
              // caption: '+ 1',
              color: Colors.red[200],
              icon: Icons.remove,
              // onTap: () => _showSnackBar('Archive'),
            ),
          )
        ],
      )
    ],
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'More',
        color: Colors.black45,
        icon: Icons.more_horiz,
        // onTap: () => _showSnackBar('More'),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        // onTap: () => _showSnackBar('Delete'),
      ),
    ],
  );
}
