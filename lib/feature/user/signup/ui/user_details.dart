import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/proxy_details.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../injection_container.dart';

class UserDetailsForm extends StatefulWidget {
  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _firstNameFieldController = TextEditingController();
  final _lastNameFieldController = TextEditingController();
  final _phoneNumberFieldController = TextEditingController();
  UserSignUpBloc _userSignUpBloc;

  @override
  void initState() {
    super.initState();
    _userSignUpBloc = sl<UserSignUpBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
        bloc: _userSignUpBloc,
        builder: (context, state) {
          if (state is UserDetailsSuccessState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProxyDetailsScreen()));
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
                      _firstNameFieldController, "First Name")),
              ThemedTextFieldFactory.create(
                  _lastNameFieldController, "Last Name"),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: ThemedTextFieldFactory.create(
                      _phoneNumberFieldController, "Phone Number (optional)",
                      type: TextInputType.phone, maxLength: 10, hideCounter: true)),
            ],
          ),
        ),
      );

  Container _buttonContainer() => Container(
        child: ThemedButtonFactory.create(200, 50, 24, "Next", () {
          String firstName = _firstNameFieldController.value.text;
          String lastName = _lastNameFieldController.value.text;
          String phoneNumber = _phoneNumberFieldController.value.text;
          _userSignUpBloc.add(UserDetailsSubmittedEvent(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
          ));
        }),
      );

  @override
  void dispose() {
    _userSignUpBloc.close();
    super.dispose();
  }
}

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: NoGlowSingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: UserDetailsForm(),
      )),
    ));
  }
}
