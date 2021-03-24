import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/theme/colors.dart';
import 'package:fieldfreshmobile/widgets/product/product_image.dart';
import 'package:flutter/widgets.dart';

class ProductHeaderFeature extends StatelessWidget {
  final Product _product;

  const ProductHeaderFeature(this._product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductImage(
                _product,
                width: 300,
              ),
            )
          ],
        ),
        Container(
          child: Column(
            children: [
              Text(
                _product.family,
                style: TextStyle(
                    fontSize: 24,
                    color: AppTheme.colors.white,
                    fontWeight: FontWeight.bold),
              ),
              if (_product.type != null) Text(_product.type, style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.colors.light.primary,
                  fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
