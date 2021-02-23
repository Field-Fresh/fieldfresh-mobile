import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/product/product_card_listItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart' as intl;

// typedef BuyProductInfoSubmittedCallback = void Function(BuyOrderProductInfo info);
// typedef SellProductInfoSubmittedCallback = void Function(SellOrderProductInfo info);

typedef ProductInfoSubmittedCallback<T extends OrderProductInfo> = void
    Function(T info);

// // ============================================================
// // Steps
// // ============================================================

class BuyProductInformationStep extends Step {
  BuyProductInformationStep(
      bool isActive,
      Product product,
      // BuyProductInfoSubmittedCallback callback,
      ProductInfoSubmittedCallback<BuyOrderProductInfo> callback,
      {StepState state = StepState.indexed})
      : super(
            title: Text("Info"),
            content: BuyProductInformationStepContent(product, callback),
            isActive: isActive,
            state: state);
}

class SellProductInformationStep extends Step {
  SellProductInformationStep(bool isActive, Product product,
      ProductInfoSubmittedCallback<SellOrderProductInfo> callback,
      // SellProductInfoSubmittedCallback callback,
      {StepState state = StepState.indexed})
      : super(
            title: Text("Info"),
            content: SellProductInformationStepContent(product, callback),
            isActive: isActive,
            state: state);
}

// // ============================================================
// // Step Content
// // ============================================================
//

class BuyProductInformationStepContent extends StatefulWidget {
  final Product product;

  // final BuyProductInfoSubmittedCallback callback;
  final ProductInfoSubmittedCallback<BuyOrderProductInfo> callback;

  const BuyProductInformationStepContent(
    this.product,
    this.callback, {
    Key key,
  }) : super(key: key);

  @override
  _BuyProductInformationStepContentState createState() {
    return _BuyProductInformationStepContentState(product, callback);
  }
}

class SellProductInformationStepContent extends StatefulWidget {
  final Product product;
  final ProductInfoSubmittedCallback<SellOrderProductInfo> callback;

  // final SellProductInfoSubmittedCallback callback;

  const SellProductInformationStepContent(
    this.product,
    this.callback, {
    Key key,
  }) : super(key: key);

  @override
  _SellProductInformationStepContentState createState() {
    return _SellProductInformationStepContentState(product, callback);
  }
}

//
// // ============================================================
// // Step Content State
// // ============================================================
//
abstract class _ProductInformationStepContentState<O extends OrderProductInfo>
    extends State {
  final _formKey = GlobalKey<FormBuilderState>();
  final ProductInfoSubmittedCallback<O> callback;

  // final BuyProductInfoSubmittedCallback callback;
  final Product _product;

  _ProductInformationStepContentState(this._product, this.callback);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (_product != null)
          Container(
              margin: EdgeInsets.only(bottom: 16),
              child: ProductCardListItem(_product)),
        FormBuilder(
          key: _formKey,
          child: Container(
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getFormContent(_product),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ThemedButtonFactory.create(95, 45, 14, "Submit", () {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  var info = handleValidSubmission(_formKey.currentState);
                  callback.call(info);
                }
              })
            ],
          ),
        )
      ],
    );
  }

  Container getVolumePrice(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: FormBuilderTextField(
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.min(context, 1.0,
                      errorText: "Must be greater than 1"),
                  FormBuilderValidators.required(context),
                ]),
                style: TextStyle(color: AppTheme.colors.light.primary),
                decoration: InputDecoration(
                    suffix: Text(
                      "Lbs",
                      style: TextStyle(color: AppTheme.colors.white),
                    ),
                    labelText: "Volume",
                    labelStyle: TextStyle(color: AppTheme.colors.white)),
                keyboardType: TextInputType.number,
                name: "volume",
              ),
            ),
            Container(
              width: 150,
              child: FormBuilderTextField(
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.min(context, 1.0,
                      errorText: "Must be greater than 1"),
                  FormBuilderValidators.required(context),
                ]),
                style: TextStyle(color: AppTheme.colors.light.primary),
                decoration: InputDecoration(
                    suffix: Text("/Lbs",
                        style: TextStyle(color: AppTheme.colors.white)),
                    prefix: Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Text("CAD",
                          style: TextStyle(color: AppTheme.colors.white)),
                    ),
                    labelText: "Min cost per unit",
                    labelStyle:
                        TextStyle(color: AppTheme.colors.white, fontSize: 16)),
                keyboardType: TextInputType.number,
                name: "cost_per_unit",
              ),
            )
          ],
        ),
      );

  List<DateTime> getMatchingPeriod(FormBuilderState formState) =>
      formState.value['matching_period'];

  List<Widget> getFormContent(Product product);

  OrderProductInfo handleValidSubmission(FormBuilderState formState);
}

class _BuyProductInformationStepContentState
    extends _ProductInformationStepContentState<BuyOrderProductInfo> {
  _BuyProductInformationStepContentState(Product product,
      ProductInfoSubmittedCallback<BuyOrderProductInfo> callback)
      // BuyProductInfoSubmittedCallback callback)
      : super(product, callback);

  @override
  List<Widget> getFormContent(Product product) => [
        Container(
          child: FormBuilderDateRangePicker(
            name: "matching_period",
            validator: FormBuilderValidators.required(context),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            initialFirstDate: DateTime.now(),
            initialLastDate: DateTime.now().add(Duration(days: 5)),
            format: intl.DateFormat('yyyy-MM-dd'),
            style: TextStyle(color: AppTheme.colors.light.primary),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.justify,
            decoration: InputDecoration(
              fillColor: AppTheme.colors.white.withOpacity(0.3),
              labelText: 'Matching Period',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                  color: AppTheme.colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              hintStyle: TextStyle(color: AppTheme.colors.white),
              helperStyle: TextStyle(color: AppTheme.colors.white),
              helperMaxLines: 4,
              helperText:
                  'Please select the first and last day you would like to receive order matches. '
                  'Please account for your lead time and product quality.',
            ),
          ),
        ),
        getVolumePrice(context)
      ];

  @override
  BuyOrderProductInfo handleValidSubmission(FormBuilderState formState) {
    var matchingPeriod = getMatchingPeriod(formState);
    return BuyOrderProductInfo(
        volume: double.parse(_formKey.currentState.value['volume']),
        unitMaxPrice:
            double.parse(_formKey.currentState.value['cost_per_unit']),
        matchingPeriodStart: matchingPeriod[0],
        matchingPeriodEnd: matchingPeriod[1]);
  }
}

class _SellProductInformationStepContentState
    extends _ProductInformationStepContentState<SellOrderProductInfo> {
  _SellProductInformationStepContentState(Product product,
      ProductInfoSubmittedCallback<SellOrderProductInfo> callback
      // BuyProductInfoSubmittedCallback callback
      )
      : super(product, callback);

  @override
  List<Widget> getFormContent(Product product) => [
        Container(
          child: FormBuilderSlider(
            validator: FormBuilderValidators.required(context),
            label: "Service Radius (Km)",
            divisions: 245,
            textStyle: TextStyle(
                color: AppTheme.colors.light.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            name: "service_radius",
            decoration: InputDecoration(
              labelStyle: TextStyle(color: AppTheme.colors.white, fontSize: 20),
              labelText: 'Service Radius (Km)',
            ),
            min: 5,
            max: 250,
            minTextStyle: TextStyle(color: AppTheme.colors.white),
            maxTextStyle: TextStyle(color: AppTheme.colors.white),
            initialValue: 50,
          ),
        ),
        Container(
          child: FormBuilderDateRangePicker(
            name: "matching_period",
            validator: FormBuilderValidators.required(context),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            initialFirstDate: DateTime.now(),
            initialLastDate: DateTime.now().add(Duration(days: 5)),
            format: intl.DateFormat('yyyy-MM-dd'),
            style: TextStyle(color: AppTheme.colors.light.primary),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.justify,
            decoration: InputDecoration(
              fillColor: AppTheme.colors.white.withOpacity(0.3),
              labelText: 'Matching Period',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                  color: AppTheme.colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              hintStyle: TextStyle(color: AppTheme.colors.white),
              helperStyle: TextStyle(color: AppTheme.colors.white),
              helperMaxLines: 4,
              helperText:
                  'Please select the first and last day you would like to receive order matches. '
                  'Please account for your lead time and product quality.',
            ),
          ),
        ),
        getVolumePrice(context)
      ];

  @override
  SellOrderProductInfo handleValidSubmission(FormBuilderState formState) {
    var matchingPeriod = getMatchingPeriod(formState);
    return SellOrderProductInfo(
        serviceRadius: _formKey.currentState.value['service_radius'],
        volume: double.parse(_formKey.currentState.value['volume']),
        unitMinPrice:
            double.parse(_formKey.currentState.value['cost_per_unit']),
        matchingPeriodStart: matchingPeriod[0],
        matchingPeriodEnd: matchingPeriod[1]);
  }
}

abstract class OrderProductInfo {
  final DateTime matchingPeriodStart;
  final DateTime matchingPeriodEnd;
  final double volume;

  OrderProductInfo(
      this.matchingPeriodStart, this.matchingPeriodEnd, this.volume);
}

class BuyOrderProductInfo extends OrderProductInfo {
  final double unitMaxPrice;

  BuyOrderProductInfo(
      {volume, this.unitMaxPrice, matchingPeriodStart, matchingPeriodEnd})
      : super(matchingPeriodStart, matchingPeriodEnd, volume);
}

class SellOrderProductInfo extends OrderProductInfo {
  final double serviceRadius;
  final double unitMinPrice;

  SellOrderProductInfo(
      {this.serviceRadius,
      volume,
      this.unitMinPrice,
      matchingPeriodStart,
      matchingPeriodEnd})
      : super(matchingPeriodStart, matchingPeriodEnd, volume);
}
