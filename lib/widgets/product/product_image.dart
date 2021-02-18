import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/widgets/product/product_class_stamp.dart';
import 'package:flutter/widgets.dart';

class ProductImage extends StatelessWidget {
  final Product _product;

  const ProductImage(this._product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.network(
          _product.imgUrl,
          width: 180,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          child: ProductClassStamp(_product.classType),
          margin: EdgeInsets.all(4),
        )
      ],
    );
  }
}
