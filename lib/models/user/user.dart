class User {
  String id;
  String firstName;
  String lastName;
  String phone;
  String email;

  User({this.email, this.firstName, this.lastName, this.phone, this.id});

  static User fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      id: json['profileId'],
    );
  }
}