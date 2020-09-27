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
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserSignUpBloc>(
          create: (context) => UserSignUpBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SingUpScreen(),
      ),
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
            hintText: S.SIGNUP_EMAIL_PLACEHOLDER
        ),
      ),
      TextField(
        controller: _passwordFieldController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: S.SIGNUP_PASSWORD_PLACEHOLDER
        ),
      ),
      TextField(
        controller: _retypedPasswordFieldController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: S.SIGNUP_PASSWORD_PLACEHOLDER
        ),
      ),
      RaisedButton(
        child: Text("Sign Up"),
        onPressed: () {
          String password = _passwordFieldController.value.text;
          String retypedPassword = _retypedPasswordFieldController.value.text;
          String email = _emailFieldController.value.text;
          _userSignUpBloc.add(UserSignUpRequestEvent(
            email: email,
            password: password,
            retypedPassword: retypedPassword,
          ));
        },
      )
    ]);
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
