import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/proxy_details.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_details.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../injection_container.dart';

class UserSignUpForm extends StatefulWidget {
  @override
  _UserSignUpFormState createState() => _UserSignUpFormState();
}

class _UserSignUpFormState extends State<UserSignUpForm> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _confirmPasswordFieldController = TextEditingController();
  UserSignUpBloc _userSignUpBloc;

  @override
  void initState() {
    super.initState();
    _userSignUpBloc = BlocProvider.of<UserSignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
        cubit: _userSignUpBloc,
        builder: (context, state) {
          if (state is SignUpStateSuccess) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsScreen()));
            });
          }

          return Column(
            children: [
              _logoContainer(),
              _infoImageContainer(),
              _userDetailsFormContent(),
              _buttonContainer()
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          );
        });
  }

  Container _logoContainer() => Container(
        child: SvgPicture.asset(
          'graphics/app-logo-small.svg',
          height: 100,
          fit: BoxFit.fitWidth,
        ),
      );

  Container _infoImageContainer() => Container(
        child: SvgPicture.asset(
          'graphics/signup-message-large.svg',
          height: 250,
          fit: BoxFit.fitHeight,
        ),
      );

  Container _userDetailsFormContent() => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: ThemedTextFieldFactory.create(
                      _emailFieldController, "Email",
                      type: TextInputType.emailAddress)),
              ThemedTextFieldFactory.createForSensitive(
                  _passwordFieldController, "Password"),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: ThemedTextFieldFactory.createForSensitive(
                      _confirmPasswordFieldController, "Confirm Password")),
            ],
          ),
        ),
      );

  Container _buttonContainer() => Container(
        child: ThemedButtonFactory.create(200, 50, 24, "Next", () {
          String email = _emailFieldController.value.text;
          String password = _passwordFieldController.value.text;
          String confirmPassword = _confirmPasswordFieldController.value.text;
          _userSignUpBloc.add(UserSignUpSubmittedEvent(
            email: email,
            password: password,
            retypedPassword: confirmPassword,
          ));
        }),
      );

}

class UserSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: NoGlowSingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: UserSignUpForm(),
      )),
    ));
  }
}
