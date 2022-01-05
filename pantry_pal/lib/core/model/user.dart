class PantryUser {
  String id = "";
  String fullName = "";
  String email = "";
  DateTime accountCreated = DateTime.now();
  List<String> groupIDs = [];

  PantryUser(); // default constructor

  PantryUser.newUser(
      String id, String fullName, String email, DateTime accountCreated)
      : id = id,
        fullName = fullName,
        email = email,
        accountCreated = accountCreated;

  PantryUser.fromMap(Map snapshot)
      : id = snapshot['id'],
        fullName = snapshot['fullName'],
        email = snapshot['email'],
        accountCreated = snapshot['accountCreated'].toDate(),
        groupIDs = snapshot['groupIDs'].cast<String>();

  Map<String, Object> toJSON() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "accountCreated": accountCreated,
      "groupIDs": groupIDs,
    };
  }

  List<String> getGroupIDs() {
    return groupIDs;
  }

  void addGroupID (String id) {
    groupIDs.add(id);
  }
}
