import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldfreshmobile/feature/orders/create/bloc/create_order_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/create/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_information/product_information_step.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_selection/product_selection_step.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/order/side_type.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderPage extends StatefulWidget {

  final Side _side;

  CreateOrderPage(this._side);


  @override
  _CreateOrderPageState createState() => _CreateOrderPageState(_side);
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  OrderCreationCubit _cubit;
  final Side _side;

  _CreateOrderPageState(this._side);


  @override
  void initState() {
    super.initState();
    _cubit = sl<OrderCreationCubit>();
  }

  Widget _ErrorBox(String error) => ConstrainedBox(
    constraints: BoxConstraints.expand(),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            error,
            style: TextStyle(
                color: AppTheme.colors.light.primary,
                fontWeight: FontWeight.bold, fontSize: 28),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.error, color: AppTheme.colors.light.errorRed,size: 50,),
          ),
          Container(margin: EdgeInsets.only(top: 8), child: ThemedButtonFactory.create(200, 40, 18, "Create new order", () { Navigator.pop(context); }))
        ],
      ),
    ),
  );

  Widget _CompletionBox(String text) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: text,
        desc: "Your order has been created!",
        btnOkOnPress: () { Navigator.pop(context); },
      ).show();
    });
    return Container();
  }

  Step _buildProductInformationStep(OrderCreationStep state){
    switch(_side){
      case Side.BUY:
        return BuyProductInformationStep(state.step == 1, state.product, (BuyOrderProductInfo info) {
          _cubit.nextWithInfo(info);
        });
      case Side.SELL:
        return SellProductInformationStep(state.step == 1, state.product, (SellOrderProductInfo info) {
          _cubit.nextWithInfo(info);
        });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: Container(
        child: BlocBuilder(
          builder: (context, OrderCreationState state) {
            if (state is OrderCreationStep) {
              return buildStep(state);
            }

            if (state is OrderCreating) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }

            if (state is OrderCreated) {
              switch(_side){
                case Side.BUY:
                  return _CompletionBox("Buy Order Created!");
                case Side.SELL:
                  return _CompletionBox("Sell Order Created!");
              }
            }

            if (state is Error) {
              return _ErrorBox("Error creating order");
            }

            return ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          cubit: _cubit,
        ),
      ),
    );
  }


  Widget buildStep(OrderCreationStep state) => Column(
        children: [
          Expanded(
            child: Theme(
              data: AppTheme.lightTheme
                  .copyWith(canvasColor: AppTheme.colors.white),
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: state.step,
                controlsBuilder: (context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  if (state.step == 0) {
                    return Container();
                  } else if (state.step == 1) {
                    return Row(
                      children: [
                        FlatButton.icon(
                            color: AppTheme.colors.white.withOpacity(0.3),
                            onPressed: () {
                              _cubit.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: AppTheme.colors.white,
                            ),
                            label: Text(
                              "Back",
                              style: TextStyle(color: AppTheme.colors.white),
                            ))
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
                steps: [
                  ProductSelectionStep(state.step == 0, (Product product) {
                    _cubit.nextWithProduct(product);
                  }),
                  _buildProductInformationStep(state)
                ],
              ),
            ),
          ),
        ],
      );
}
