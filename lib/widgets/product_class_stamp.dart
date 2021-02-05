import 'package:fieldfreshmobile/models/api/product/class_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_svg/svg.dart';

class ProductClassStamp extends StatelessWidget {
  final ProductClass classStamp;

  const ProductClassStamp(this.classStamp, {Key key}) : super(key: key);

  String stampColor(classStamp) {
    if (classStamp == ProductClass.A) {
      return 'graphics/classA.svg';
    } else if (classStamp == ProductClass.B) {
      return 'graphics/classB.svg';
    } else {
      return 'graphics/classC.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SvgPicture.asset(
      stampColor(classStamp),
      height: 30,
      fit: BoxFit.fitHeight,
    ));
  }
}
