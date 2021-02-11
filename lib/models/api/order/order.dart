import 'package:enum_to_string/enum_to_string.dart';
import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';
import 'package:fieldfreshmobile/models/api/order/status_type.dart';
import 'package:fieldfreshmobile/models/api/product/class_type.dart';

import '../field_fresh_model.dart';

class Order extends FieldFreshModel {

  Side side;
  Status status;

  Order({this.side, this.status, id}) : super(id: id);

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      side: EnumToString.fromString(Side.values, json['side']),
      status: EnumToString.fromString(Status.values, json['status']),
    );
  }
}
