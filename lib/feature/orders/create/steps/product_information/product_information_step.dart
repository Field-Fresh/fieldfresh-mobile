import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'file:///C:/src/fieldfresh-mobile/lib/widgets/product/product_card_listItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart' as intl;

// typedef ProductInfoSubmittedCallback = void Function(OrderProductInfo info);

typedef ProductInfoSubmittedCallback<T> = void Function(T info);

class ProductInformationStep extends Step {
  ProductInformationStep(bool isActive, Product product,
      ProductInfoSubmittedCallback callback,
      {StepState state = StepState.indexed})
      : super(
      title: Text("Info"),
      content: ProductInformationStepContent<T>(product, callback),
      isActive: isActive,
      state: state);
}

abstract class ProductInformationStepContent<O> extends StatefulWidget {
  final Product product;
  final ProductInfoSubmittedCallback<O> callback;

  const ProductInformationStepContent(this.product,
      this.callback, {
        Key key,
      }) : super(key: key);
}

abstract class _ProductInformationStepContentState<O extends OrderProductInfo>
    extends State<ProductInformationStepContent<O>> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ProductInfoSubmittedCallback<O> callback;
  final Product _product;

  _ProductInformationStepContentState(this._product, this.callback);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  List<DateTime> getMatchingPeriod(FormBuilderState formState) =>
      formState.value['matching_period'];

  List<Widget> getFormContent(Product product);

  O handleValidSubmission(FormBuilderState formState);
}

class _BuyProductInformationStepContentState
    extends _ProductInformationStepContentState<BuyOrderProductInfo> {
  _BuyProductInformationStepContentState(Product product,
      ProductInfoSubmittedCallback<BuyOrderProductInfo> callback)
      : super(product, callback);

  @override
  List<Widget> getFormContent(Product product) =>
      [
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
              labelText: 'Service Radius (Km) yer reddy',
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
        Container(
          margin: EdgeInsets.only(bottom: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      child: FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.min(context, 1.0,
                              errorText: "Must be greater than 1"),
                          FormBuilderValidators.required(context),
                        ]),
                        style: TextStyle(color: AppTheme.colors.light.primary),
                        decoration: InputDecoration(
                            labelText: "Volume",
                            labelStyle:
                            TextStyle(color: AppTheme.colors.white)),
                        keyboardType: TextInputType.number,
                        name: "volume",
                      ),
                    ),
                    Text(
                      "Lbs",
                      style: TextStyle(color: AppTheme.colors.light.primary),
                    )
                  ],
                ),
              ),
              Row(
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
                          labelText: "Max Cost per Unit",
                          labelStyle: TextStyle(color: AppTheme.colors.white)),
                      keyboardType: TextInputType.number,
                      name: "cost_per_unit",
                    ),
                  ),
                  Text("/Lbs",
                      style: TextStyle(color: AppTheme.colors.light.primary))
                ],
              )
            ],
          ),
        )
      ];

  @override
  BuyOrderProductInfo handleValidSubmission(FormBuilderState formState) {
    var matchingPeriod = getMatchingPeriod(formState);
    return BuyOrderProductInfo(
        serviceRadius:
        _formKey.currentState.value['service_radius'],
        volume:
        double.parse(_formKey.currentState.value['volume']),
        unitMaxPrice: double.parse(
            _formKey.currentState.value['cost_per_unit']),
        matchingPeriodStart: matchingPeriod[0],
        matchingPeriodEnd: matchingPeriod[1]);
  }
}

class _SellProductInformationStepContentState
    extends _ProductInformationStepContentState<SellOrderProductInfo> {
  _SellProductInformationStepContentState(Product product,
      ProductInfoSubmittedCallback<SellOrderProductInfo> callback)
      : super(product, callback);

  @override
  List<Widget> getFormContent(Product product) =>
      [
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
              labelText: 'Service Radius (Km) yer reddy',
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
        Container(
          margin: EdgeInsets.only(bottom: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      child: FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.min(context, 1.0,
                              errorText: "Must be greater than 1"),
                          FormBuilderValidators.required(context),
                        ]),
                        style: TextStyle(color: AppTheme.colors.light.primary),
                        decoration: InputDecoration(
                            labelText: "Volume",
                            labelStyle:
                            TextStyle(color: AppTheme.colors.white)),
                        keyboardType: TextInputType.number,
                        name: "volume",
                      ),
                    ),
                    Text(
                      "Lbs",
                      style: TextStyle(color: AppTheme.colors.light.primary),
                    )
                  ],
                ),
              ),
              Row(
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
                          labelText: "Max Cost per Unit",
                          labelStyle: TextStyle(color: AppTheme.colors.white)),
                      keyboardType: TextInputType.number,
                      name: "cost_per_unit",
                    ),
                  ),
                  Text("/Lbs",
                      style: TextStyle(color: AppTheme.colors.light.primary))
                ],
              )
            ],
          ),
        )
      ];

  @override
  SellOrderProductInfo handleValidSubmission(FormBuilderState formState) {
    var matchingPeriod = getMatchingPeriod(formState);
    return SellOrderProductInfo(
        serviceRadius:
        _formKey.currentState.value['service_radius'],
        volume:
        double.parse(_formKey.currentState.value['volume']),
        unitMinPrice: double.parse(
            _formKey.currentState.value['cost_per_unit']),
        matchingPeriodStart: matchingPeriod[0],
        matchingPeriodEnd: matchingPeriod[1]);
  }
}

abstract class OrderProductInfo {
  final DateTime matchingPeriodStart;
  final DateTime matchingPeriodEnd;
  final double volume;

  OrderProductInfo(this.matchingPeriodStart, this.matchingPeriodEnd,
      this.volume);
}

class BuyOrderProductInfo extends OrderProductInfo {
  final double serviceRadius;
  final double unitMaxPrice;

  BuyOrderProductInfo({this.serviceRadius,
    volume,
    this.unitMaxPrice,
    matchingPeriodStart,
    matchingPeriodEnd})
      : super(matchingPeriodStart, matchingPeriodEnd, volume);
}

class SellOrderProductInfo extends OrderProductInfo {
  final double serviceRadius;
  final double unitMinPrice;

  SellOrderProductInfo({this.serviceRadius,
    volume,
    this.unitMinPrice,
    matchingPeriodStart,
    matchingPeriodEnd})
      : super(matchingPeriodStart, matchingPeriodEnd, volume);
}
