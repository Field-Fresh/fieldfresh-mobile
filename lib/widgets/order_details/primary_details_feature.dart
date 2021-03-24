import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/theme/colors.dart';
import 'package:fieldfreshmobile/widgets/product/product_image.dart';
import 'package:flutter/widgets.dart';

/*
* Pricing and Volume
* */
class PrimaryDetailsFeature extends StatelessWidget {
  final double unitPrice;
  final int quantity;
  final String unit;

  const PrimaryDetailsFeature(this.unitPrice, this.quantity, this.unit,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "unit price",
                    style: TextStyle(
                        color: AppTheme.colors.light.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    "\$$unitPrice/$unit",
                    style: TextStyle(
                        color: AppTheme.colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "quantity",
                    style: TextStyle(
                        color: AppTheme.colors.light.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    "$quantity $unit",
                    style: TextStyle(
                        color: AppTheme.colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
