import 'package:fieldfreshmobile/feature/user/signup/ui/signup_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_details.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'feature/home/ui/home.dart';
import 'feature/user/signup/ui/proxy_details.dart';

void main() async {
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
          "/": (context) => SignUpScreen(),
          "/signup": (context) => SignUpScreen(),
          "/home": (context) => HomeScreen(),
        });
  }
}
