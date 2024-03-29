import 'dart:developer';

import 'package:fieldfreshmobile/app_config.dart';
import 'package:fieldfreshmobile/feature/main/main.dart';
import 'package:fieldfreshmobile/feature/orders/create/ui/create_order.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/details/ui/match_details.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/ui/pending_order_details.dart';
import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/ui/user_signup_flow_page.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'models/api/order/side_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.configure((value) {
    if (value) {
      startApp();
    } else {
      log("Error cannot start application");
    }
  });
}

void startApp() async {
  await init();
  runApp(FieldFreshApp());
}

class FieldFreshApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Field Fresh',
        theme: AppTheme.lightTheme,
        initialRoute: "/",
        routes: {
          "/": (context) => LoginScreen(),
          "/signup": (context) => UserSignupFlowPage(),
          "/main": (context) => Main(),
          "/order/buy": (context) => CreateOrderPage(Side.BUY),
          "/order/sell": (context) => CreateOrderPage(Side.SELL),
          "/order": (context) => PendingOrderDetailsPage(),
          "/match": (context) => MatchDetailsPage()
        });
  }
}
