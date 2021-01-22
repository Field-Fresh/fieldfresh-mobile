import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/ui/verify_form.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';

import '../../../../injection_container.dart';

class SingUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  final _emailFieldController = TextEditingController();
  final _nameFieldController = TextEditingController();
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
    _nameFieldController.dispose();
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

    if (state is SignUpStateFailed) {
      formCols.add(Text(
        state.error,
        style: TextStyle(color: Colors.red),
      ));
    }

    if (state is SignUpStateVerification) {
      formCols.add(SvgPicture.asset(
        'graphics/app-logo-small.svg',
        width: 600,
        height: 250,
      ));
      _emailFieldController.clear();
      _nameFieldController.clear();
      _passwordFieldController.clear();
      _retypedPasswordFieldController.clear();
      formCols.add(Container(
          margin: EdgeInsets.symmetric(vertical: 18),
          child: VerifyForm(state.user.email)));
    } else {
      formCols.addAll(
        [
          SvgPicture.asset(
            'graphics/app-logo-small.svg',
            width: 600,
            height: 100,
          ),
          SvgPicture.asset(
            'graphics/signup-message-large.svg',
            width: 600,
            height: 250,
          )
        ],
      );
      formCols.addAll(_formForSignup(context));
    }

    return formCols;
  }

  List<Widget> _formForSignup(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
          child: ThemedTextFieldFactory.create(_nameFieldController, "Name")),
      Container(
          margin: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          child: ThemedTextFieldFactory.create(
              _emailFieldController, "Email Address")),
      Container(
          margin: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          child: ThemedTextFieldFactory.createForSensitive(
              _passwordFieldController, "Password")),
      Container(
          margin: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          child: ThemedTextFieldFactory.createForSensitive(
              _retypedPasswordFieldController, "Confirm Password")),
      ThemedButtonFactory.create(200, 50, 24, "Sign Up", () {
        String password = _passwordFieldController.value.text;
        String retypedPassword = _retypedPasswordFieldController.value.text;
        String email = _emailFieldController.value.text;
        String name = _nameFieldController.value.text;
        _userSignUpBloc.add(UserSignUpRequestEvent(
          name: name,
          email: email,
          password: password,
          retypedPassword: retypedPassword,
        ));
      }),
      Container(
        margin: EdgeInsets.only(top: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/");
          },
          child: Text('Go back',
              style: TextStyle(color: AppTheme.colors.white, fontSize: 16)),
        ),
      )
    ];
  }
}

class SingUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NoGlowSingleChildScrollView(
            child: Center(
                child: Padding(
      padding: EdgeInsets.all(8),
      child: SingUpForm(),
    ))));
  }
}
