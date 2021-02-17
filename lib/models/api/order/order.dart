import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';

import '../field_fresh_model.dart';

class Order extends FieldFreshModel {

  Side side;
  bool isActive;

  Order({this.side, this.isActive, id}) : super(id: id);

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      side: EnumToString.fromString(Side.values, json['side']),
      isActive: json['isActive'],
    );
  }
}
