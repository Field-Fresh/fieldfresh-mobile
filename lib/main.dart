import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/signup_page.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/home/ui/home.dart';
import 'feature/user/signup/ui/user_signup.dart';

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
            "/home": (context) => HomeScreen(),
          }),
    );
  }
}
