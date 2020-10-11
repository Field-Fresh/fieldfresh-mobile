import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_bloc.dart';
import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_state.dart';
import 'package:fieldfreshmobile/feature/user/login/event/events.dart';
import 'package:fieldfreshmobile/feature/user/login/state/states.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/signup_page.dart';
import 'package:fieldfreshmobile/feature/user/verify/ui/verify_form.dart';
import 'package:fieldfreshmobile/util/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../injection_container.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  UserLoginBloc _userLoginBloc;

  @override
  void initState() {
    super.initState();
    _userLoginBloc = sl<UserLoginBloc>();
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginBloc, UserLoginState>(
        bloc: _userLoginBloc,
        builder: (context, state) {
          return Column(
            children: _formFromState(context, state),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          );
        });
  }

  List<Widget> _formFromState(BuildContext context, UserLoginState state) {
    final List<Widget> formCols = [
      SvgPicture.asset('graphics/placeholder-logo.svg'),
    ];

    if (state is UserLoginStateEmpty) {
      formCols.addAll(_formForLogin(context));
    } else if (state is UserLoginStateVerificationRequired) {
      _emailFieldController.clear();
      _passwordFieldController.clear();
      formCols.addAll([
        VerifyForm(state.email),
        GestureDetector(
            onTap: () {
              _userLoginBloc.add(UserReturnToLoginEvent());
            },
            child: Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  "Not you? Click to login with different email.",
                  style: TextStyle(
                      color: Colors.black87,
                      decoration: TextDecoration.underline),
                )))
      ]);
    } else if (state is UserLoginStateFailed) {
      formCols.add(Container(
        margin: EdgeInsets.only(bottom: 16, left: 24, right: 24),
        child: Text(
          state.error,
          style: TextStyle(color: Colors.red),
        ),
      ));
      formCols.addAll(_formForLogin(context));
    } else if (state is UserLoginStateSuccess) {
      formCols.addAll(_formForLogin(context));
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, "/home");
      });
    }

    return formCols;
  }

  List<Widget> _formForLogin(BuildContext context) {
    return [
      Container(
        margin: EdgeInsets.only(bottom: 16, left: 24, right: 24),
        child: TextField(
          controller: _emailFieldController,
          decoration: InputDecoration(hintText: "Email"),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
        child: TextField(
          controller: _passwordFieldController,
          obscureText: true,
          decoration: InputDecoration(hintText: "Password"),
        ),
      ),
      ButtonBar(
        children: [
          RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Login",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            color: Colors.deepOrange,
            onPressed: () {
              String password = _passwordFieldController.value.text;
              String email = _emailFieldController.value.text;
              _userLoginBloc
                  .add(UserLoginRequestEvent(email: email, password: password));
            },
          ),
          RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign Up",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            color: Colors.orangeAccent,
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/signup");
            },
          ),
        ],
        alignment: MainAxisAlignment.center,
      ),
    ];
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: LoginForm(),
        ));
  }
}
