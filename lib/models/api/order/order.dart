import 'package:enum_to_string/enum_to_string.dart';
import 'file:///C:/src/fieldfresh-mobile/lib/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/field_fresh_model.dart';

class Order extends FieldFreshModel {

  Side side;
  bool isActive;
  String proxyId;

  Order({this.proxyId, this.side, this.isActive, id}) : super(id: id);

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      side: EnumToString.fromString(Side.values, json['side']),
      isActive: json['isActive'],
      proxyId: json["proxyId"]
    );
  }
}
