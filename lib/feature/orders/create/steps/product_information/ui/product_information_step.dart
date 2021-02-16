import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInformationStep extends Step {
  ProductInformationStep(bool isActive, { StepState state = StepState.indexed})
      : super(
            title: Text("Info"),
            content: ProductInformationStepContent(),
            isActive: isActive,
            state: state);
}

class ProductInformationStepContent extends StatefulWidget {
  @override
  _ProductInformationStepContentState createState() =>
      _ProductInformationStepContentState();
}

class _ProductInformationStepContentState
    extends State<ProductInformationStepContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Stuff"),
    );
  }
}
