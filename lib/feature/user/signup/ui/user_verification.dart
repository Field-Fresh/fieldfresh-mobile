import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/verify/ui/verify_form.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../injection_container.dart';

class UserVerificationForm extends StatefulWidget {
  @override
  _UserVerificationFormState createState() => _UserVerificationFormState();
}

class _UserVerificationFormState extends State<UserVerificationForm> {
  UserSignUpBloc _userSignUpBloc;

  @override
  void initState() {
    super.initState();
    _userSignUpBloc = BlocProvider.of<UserSignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
        bloc: _userSignUpBloc,
        builder: (context, state) {
          return Column(
            children: [
              _logoContainer(),
              _infoImageContainer(),
              _userDetailsFormContent()
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 38),
          child: VerifyForm(_userSignUpBloc.user.email),
        ),
      );

}

class UserVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: NoGlowSingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: UserVerificationForm(),
      )),
    ));
  }
}
