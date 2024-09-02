class UserData {
  String? name;
  String? email;
  String? phoneNumber;

  UserData({this.name, this.email, this.phoneNumber});

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}