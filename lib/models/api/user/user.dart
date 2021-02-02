import '../field_fresh_model.dart';

class User extends FieldFreshModel {
  String firstName;
  String lastName;
  String phone;
  String email;

  User({this.email, this.firstName, this.lastName, this.phone, id})
      : super(id: id);

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
