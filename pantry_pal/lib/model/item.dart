import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';

class Item {
  String name;
  int shelfNum;
  int quantity;

  Item({@required this.name, @required this.shelfNum, @required this.quantity});
}