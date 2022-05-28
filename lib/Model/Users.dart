class Users {
  String userid;
  Users({this.userid});
}

class UserData {
  final String uid;
  final String fullname;
  final String username;
  final String contact;

  UserData({this.uid, this.fullname, this.username, this.contact});

  factory UserData.fromDatabase(Map<String, dynamic> data) {
    return UserData(
        uid: data['userid'],
        fullname: data['fullname'],
        username: data['username'],
        contact: data['contact']);
  }

  Map<String, dynamic> toDatabase() {
    return {
      'uid': uid,
      'fullname': fullname,
      'username': username,
      'contact': contact
    };
  }

  String getUid() {
    return uid;
  }

  String getUsername() {
    return username;
  }
}
