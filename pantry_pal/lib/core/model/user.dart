class PantryUser {
  String fullName = "";
  String email = "";
  DateTime accountCreated = DateTime.now();
  List<String> groupIDs = [];

  PantryUser(String fullName, String email, DateTime accountCreated) {
    this.fullName = fullName;
    this.email = email;
    this.accountCreated = accountCreated;
  }

  Map<String, Object> toJSON() {
    return {
      "fullName": fullName,
      "email": email,
      "accountCreated": accountCreated,
    };
  }
}