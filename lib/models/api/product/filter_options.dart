
import 'package:fieldfreshmobile/models/api/product/class_type.dart';

class FilterOptions {
  final List<String> categories;
  final List<String> families;
  final List<String> types;
  final List<ProductClass> classes;

  FilterOptions({this.categories, this.families, this.types, this.classes});

  //TODO implement
  static FilterOptions fromJson(Map<String, dynamic> json) {
    return FilterOptions();
  }
}