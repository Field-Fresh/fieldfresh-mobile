import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(FieldFreshApp());
}

class FieldFreshApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SingUpScreen(),
    );
  }
}

class SingUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _retypedPasswordFieldController = TextEditingController();
  UserSignUpBloc _userSignUpBloc;

  @override
  void initState() {
    super.initState();
    _userSignUpBloc = BlocProvider.of<UserSignUpBloc>(context);
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _retypedPasswordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: _emailFieldController,
        decoration: InputDecoration(
            prefix: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Text("Email:"),
            ),
            hintText: S.SIGNUP_EMAIL_PLACEHOLDER),
      ),
      TextField(
        controller: _passwordFieldController,
        decoration: InputDecoration(
            prefix: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Text("Password:"),
            ),
            hintText: S.SIGNUP_PASSWORD_PLACEHOLDER),
      ),
      TextField(
        controller: _retypedPasswordFieldController,
        decoration: InputDecoration(
            prefix: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Text("Confirm Password:"),
            ),
            hintText: S.SIGNUP_PASSWORD_PLACEHOLDER),
      ),
      RaisedButton(
        onPressed: () {
          String password = _passwordFieldController.value.text;
          String retypedPassword =
              _retypedPasswordFieldController.value.text;
          String email = _emailFieldController.value.text;
          _userSignUpBloc.add(UserSignUpRequestEvent(
            email: email,
            password: password,
            retypedPassword: retypedPassword,
          ));
        },
      )
    ]);
    // return BlocBuilder<UserSignUpBloc, UserSignUpState>(
    //     bloc: BlocProvider.of<UserSignUpBloc>(context),
    //     builder: (BuildContext context, UserSignUpState state) {
    //
    //     });
  }
}

class SingUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.TITLE),
        ),
        body: Column(
          children: <Widget>[SingUpForm()],
        ));
  }
}
