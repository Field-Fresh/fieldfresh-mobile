import 'package:fieldfreshmobile/feature/orders/pending_orders/bloc/states.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/product/product_image.dart';
import 'package:flutter/widgets.dart';

class PendingOrderItemView extends StatelessWidget {
  final PendingOrderItemData _data;

  const PendingOrderItemView(this._data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = _data.product;
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 300),
      child: Row(
        children: [
          ProductImage(product),
          _getProductDesc(product),

        ],
      ),
    );
  }
}

Container _getProductDesc(Product product) => Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              product.family,
              style: TextStyle(
                  color: AppTheme.colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Text(
            product.type,
            style: TextStyle(color: AppTheme.colors.white, fontSize: 14),
          ),
        ],
      ),
    );



