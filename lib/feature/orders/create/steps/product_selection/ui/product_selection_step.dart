import 'package:fieldfreshmobile/feature/products/product_search/ui/product_search.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:flutter/material.dart';

typedef ProductSelectionListener = void Function(Product product);

class ProductSelectionStep extends Step {
  ProductSelectionStep(
      bool isActive, ProductSelectionListener onProductSelected,
      {StepState state = StepState.indexed})
      : super(
            title: Text("Product Selection"),
            content: ProductSelectionStepContent(onProductSelected),
            isActive: isActive,
            state: state);
}

class ProductSelectionStepContent extends StatefulWidget {
  final ProductSelectionListener onProductSelection;

  const ProductSelectionStepContent(this.onProductSelection, {Key key})
      : super(key: key);

  @override
  _ProductSelectionStepContentState createState() =>
      _ProductSelectionStepContentState(onProductSelection);
}

class _ProductSelectionStepContentState
    extends State<ProductSelectionStepContent> {
  final ProductSelectionListener onProductSelection;

  _ProductSelectionStepContentState(this.onProductSelection);

  @override
  Widget build(BuildContext context) {
    return ProductSearch((Product product) {
      onProductSelection.call(product);
    });
  }
}
