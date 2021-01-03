class Item {
  String id;
  String name;
  String shelfNum;
  int quantity;
  DateTime lastUpdated;

  // Constructor for Assignment to members
  Item({this.id, this.name, this.shelfNum, this.quantity, this.lastUpdated});

  // Named Constructor
  // Maps data from Firebase JSON format to Class Item format
  // NOTE: '??' means if null
  Item.fromMap(Map snapshot, String id) :
    id = id ?? '',
    name = snapshot['name'] ?? 'New Item',
    shelfNum = snapshot['shelfNum'] ?? 'N/A',
    quantity = snapshot['quantity'] ?? 0,
    lastUpdated = snapshot['lastUpdated'] ?? DateTime.now();

  // Converts Item to JSON format for upload to Firebase
  Map toJSON() {
    return {
      "id": id,
      "name": name,
      "shelfNum": shelfNum,
      "quantity": quantity,
      "lastUpdated": lastUpdated,
    };
  }
}