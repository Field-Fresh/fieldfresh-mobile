import 'package:fieldfreshmobile/feature/main/main.dart';
import 'package:fieldfreshmobile/feature/orders/create/ui/create_order.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/ui/pending_order_details.dart';
import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/user/signup/ui/user_signup.dart';
import 'models/api/order/side_type.dart';

void main() async {
  await init();

  runApp(FieldFreshApp());
}

class FieldFreshApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<UserSignUpBloc>(),
        )
      ],
      child: MaterialApp(
          title: 'Field Fresh',
          theme: AppTheme.lightTheme,
          initialRoute: "/",
          routes: {
            "/": (context) => LoginScreen(),
            "/signup": (context) => UserSignUpScreen(),
            "/main": (context) => Main(),
            "/order/buy": (context) => CreateOrderPage(Side.BUY),
            "/order/sell": (context) => CreateOrderPage(Side.SELL),
            "/order": (context) => PendingOrderDetailsPage()
          }),
    );
  }
}
