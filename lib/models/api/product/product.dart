import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/models/api/product/class_type.dart';

import '../field_fresh_model.dart';

class Product extends FieldFreshModel {
  String type;
  String catagory;
  String family;
  String imgUrl;
  String units;
  ProductClass classType;

  Product(
      {this.type,
      this.catagory,
      this.family,
      this.classType,
      this.imgUrl,
      this.units,
      id})
      : super(id: id);

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      type: json['type'],
      catagory: json['catagory'],
      family: json['family'],
      classType: EnumToString.fromString(ProductClass.values, json['classType']),
      imgUrl: json['imageURL'] ?? "https://source.unsplash.com/daily",
      units: json['units'],
      id: json['productId'],
    );
  }
}
