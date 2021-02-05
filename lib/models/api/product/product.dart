import 'package:fieldfreshmobile/models/api/product/class_type.dart';

import '../field_fresh_model.dart';

class Product extends FieldFreshModel {
  String type;
  String catagory;
  String family;
  String imgUrl;
  int value;
  String units;
  ProductClass classType;

  Product(
      {this.type,
      this.catagory,
      this.family,
      this.classType,
      this.imgUrl,
      this.value,
      this.units,
      id})
      : super(id: id);

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      type: json['type'],
      catagory: json['catagory'],
      family: json['family'],
      classType: json['classType'],
      imgUrl: json['imageURL'],
      value: json['value'],
      units: json['units'],
      id: json['productId'],
    );
  }
}
