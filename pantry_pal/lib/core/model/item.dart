class Item {
  String id = "defaultID";
  String name;
  String shelfNum;
  int quantity;
  DateTime lastUpdated;

  // Constructor for Assignment to members
  Item(String id, String name, String shelfNum, int quantity, DateTime lastUpdated)
    : id = id,
      name = name,
      shelfNum = shelfNum,
      quantity = quantity,
      lastUpdated = lastUpdated;
  
  Item.noID(String name, String shelfNum, int quantity, DateTime lastUpdated)
      : name = name,
        shelfNum = shelfNum,
        quantity = quantity,
        lastUpdated = lastUpdated;

  // Named Constructor
  // Maps data from Firebase JSON format to Class Item format
  // NOTE: '??' means if null
  Item.fromMap(Map snapshot, String id)
      : id = id,
        name = snapshot['name'] ?? 'New Item',
        shelfNum = snapshot['shelfNum'] ?? 'N/A',
        quantity = snapshot['quantity'] ?? 0,
        lastUpdated = snapshot['lastUpdated'].toDate() ?? DateTime.now();

  // Converts Item to JSON format for upload to Firebase
  Map<String, Object> toJSON() {
    return {
      "id": id,
      "name": name,
      "shelfNum": shelfNum,
      "quantity": quantity,
      "lastUpdated": lastUpdated,
    };
  }
}
