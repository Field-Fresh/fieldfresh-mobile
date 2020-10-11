import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/ui/verify_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../injection_container.dart';

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
    _userSignUpBloc = sl<UserSignUpBloc>();
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
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
        bloc: _userSignUpBloc,
        builder: (context, state) {
          return Column(
            children: _formFromState(context, state),
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          );
        });
  }

  List<Widget> _formFromState(BuildContext context, UserSignUpState state) {
    final List<Widget> formCols = [];
    formCols.add(SvgPicture.asset('graphics/placeholder-logo.svg'));

    if (state is SignUpStateFailed) {
      formCols.add(Text(
        state.error,
        style: TextStyle(color: Colors.red),
      ));
    }

    if (state is SignUpStateVerification) {
      _emailFieldController.clear();
      _passwordFieldController.clear();
      _retypedPasswordFieldController.clear();
      formCols.add(VerifyForm(state.user.email));
    } else if (state is SignUpStateVerificationSuccess) {
      // No/op
    } else {
      formCols.addAll(_formForSignup(context));
    }

    return formCols;
  }

  List<Widget> _formForSignup(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "Please enter the info below",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
        child: TextField(
          controller: _emailFieldController,
          decoration: InputDecoration(hintText: "Email"),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        child: TextField(
          controller: _passwordFieldController,
          obscureText: true,
          decoration: InputDecoration(hintText: "Password"),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        child: TextField(
          controller: _retypedPasswordFieldController,
          obscureText: true,
          decoration: InputDecoration(hintText: "Confirm Password"),
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
    ];
  }
}

class SingUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SingUpForm(),
          ),
        ));
  }
}
