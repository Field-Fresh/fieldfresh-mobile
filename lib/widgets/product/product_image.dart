import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/widgets/product/product_class_stamp.dart';
import 'package:flutter/widgets.dart';

class ProductImage extends StatelessWidget {
  final Product _product;

  final double width;
  final double height;

  const ProductImage(this._product, {Key key, this.width=180, this.height=100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.network(
          _product.imgUrl,
          width: this.width,
          height: this.height,
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
