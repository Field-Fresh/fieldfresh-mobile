import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_bloc.dart';
import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_state.dart';
import 'package:fieldfreshmobile/feature/user/login/event/events.dart';
import 'package:fieldfreshmobile/feature/user/login/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/ui/verify_form.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/cupertino.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'graphics/app-logo-large.svg',
                    height: 350,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: _formFromState(context, state),
              )
            ],
          );
        });
  }

  List<Widget> _formFromState(BuildContext context, UserLoginState state) {
    final List<Widget> formCols = [];

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
                      color: AppTheme.colors.white,
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
        Navigator.pushReplacementNamed(context, "/main");
      });
    }

    return formCols;
  }

  List<Widget> _formForLogin(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(bottom: 16, left: 24, right: 24),
          child: ThemedTextFieldFactory.create(_emailFieldController, "Email",
              type: TextInputType.emailAddress)),
      Container(
          margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
          child: ThemedTextFieldFactory.createForSensitive(
              _passwordFieldController, "Password")),
      ThemedButtonFactory.create(200, 50, 24, "Login", () {
        String password = _passwordFieldController.value.text;
        String email = _emailFieldController.value.text;
        _userLoginBloc
            .add(UserLoginRequestEvent(email: email, password: password));
      }),
      Container(
        margin: EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New user?",
              style: TextStyle(color: AppTheme.colors.white, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: AppTheme.colors.light.primary, fontSize: 24),
                  )),
            )
          ],
        ),
      )
    ];
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: NoGlowSingleChildScrollView(
        child: LoginForm(),
      ),
    ));
  }
}
