
class Group {
  String id = "";
  String name ="";
  String leader = "";
  List<String> members = [];
  DateTime groupCreated = DateTime.now();
  // TODO: Need to add a list of inventories

  Group();

  Group.newGroup(String name, String leader, List<String> members, DateTime groupCreated)
    : name = name,
      leader = leader,
      members = members,
      groupCreated = groupCreated;
      

  Group.fromMap(Map snapshot) {
    id = snapshot["id"];
    name = snapshot["name"];
    leader = snapshot["leader"];
    members = snapshot["members"].cast<String>();
    groupCreated = snapshot["groupCreated"].toDate();
  }

  Map<String, Object> toJSON() {
    return {
      "id": id,
      "name": name,
      "leader": leader,
      "members": members,
      "groupCreated": groupCreated,
    };
  }

  void setID (String id) {
    this.id = id;
  }

  void addMember (String memID) {
    this.members.add(memID);
  }
}