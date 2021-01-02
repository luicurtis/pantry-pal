import 'package:flutter/foundation.dart';

class Item {
  String name;
  int shelfNum;
  int quantity;
  DateTime lastUpdated;

  Item({@required this.name, 
  @required this.shelfNum, 
  @required this.quantity,
  @required this.lastUpdated,
  });
}