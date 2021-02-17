import 'package:fieldfreshmobile/feature/orders/create/buy/bloc/create_buy_order_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/create/buy/bloc/states.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_information/product_information_step.dart';
import 'package:fieldfreshmobile/feature/orders/create/steps/product_selection/product_selection_step.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/models/api/product/product.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBuyOrderPage extends StatefulWidget {
  @override
  _CreateBuyOrderPageState createState() => _CreateBuyOrderPageState();
}

class _CreateBuyOrderPageState extends State<CreateBuyOrderPage> {
  BuyOrderCreationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<BuyOrderCreationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FieldFreshAppBar(),
      body: Container(
        child: BlocBuilder(
          builder: (context, BuyOrderCreationState state) {
            if (state is BuyOrderCreationStep) {
              return buildStep(state);
            }

            if (state is BuyOrderCreating) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }

            if (state is BuyOrderCreated) {
              return ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Buy Order Created!",
                        style: TextStyle(
                            color: AppTheme.colors.light.primary,
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Icon(Icons.check_circle, color: AppTheme.colors.white,size: 50,),
                      ),
                      Container(margin: EdgeInsets.only(top: 8), child: ThemedButtonFactory.create(100, 40, 18, "Done", () { Navigator.pop(context); }))
                    ],
                  ),
                ),
              );
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

  Widget buildStep(BuyOrderCreationStep state) => Column(
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
                  ProductInformationStep(state.step == 1, state.product,
                      (BuyOrderProductInfo info) {
                    _cubit.nextWithInfo(info);
                  })
                ],
              ),
            ),
          ),
        ],
      );
}
