import '../field_fresh_model.dart';

class Proxy extends FieldFreshModel {
  String name;
  String description;
  String streetAddress;
  String city;
  String province;
  String country;
  String postalCode;
  double lat;
  double long;

  Proxy(
      {this.name,
      this.description,
      this.streetAddress,
      this.country,
      this.city,
      this.province,
      this.postalCode,
      this.lat,
      this.long,
      id})
      : super(id: id);

}
