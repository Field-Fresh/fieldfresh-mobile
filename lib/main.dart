import 'package:fieldfreshmobile/feature/user/signup/ui/signup_page.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:flutter/material.dart';

import 'feature/home/ui/home.dart';
import 'feature/user/login/ui/login_page.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => LoginScreen(),
          "/signup": (context) => SingUpScreen(),
          "/home": (context) => HomeScreen(),
        }
    );
  }
}
