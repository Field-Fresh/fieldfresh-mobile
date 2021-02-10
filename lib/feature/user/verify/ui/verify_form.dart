import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_state.dart';
import 'package:fieldfreshmobile/feature/user/verify/event/events.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

import '../../../../injection_container.dart';

class VerifyForm extends StatefulWidget {
  final String email;

  VerifyForm(this.email);

  @override
  State<StatefulWidget> createState() => _VerifyFormState(email);
}

class _VerifyFormState extends State<VerifyForm> {
  final String email;
  VerifyBloc _verifyBloc;

  _VerifyFormState(this.email);

  @override
  void initState() {
    super.initState();
    _verifyBloc = sl<VerifyBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyBloc, VerifyState>(
        cubit: _verifyBloc,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: _formFromState(context, state),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          );
        });
  }

  List<Widget> _formFromState(BuildContext context, VerifyState state) {
    final List<Widget> formCols = [];

    if (state is VerifyFailedState) {
      formCols.add(Text(
        state.error ?? "An Error has occured",
        style: TextStyle(color: Colors.red),
      ));
    }

    if (state is VerifySuccessState) {
      formCols.addAll(_widgetsForVerificaitonSuccess(context, state));
      return formCols;
    } else {
      formCols.addAll(_formForVerification(context));
    }

    Text actionText;
    if (state is ResendVerifyCodeFailureState) {
      actionText = Text(
        "Failed to resend verification code",
        style:
        TextStyle(color: Colors.red, decoration: TextDecoration.underline),
      );
    } else if (state is ResendVerifyCodeSuccessState) {
      actionText = Text(
        "Successfully resent verification code",
        style: TextStyle(
            color: AppTheme.colors.light.primary,
            decoration: TextDecoration.underline),
      );
    } else {
      actionText = Text(
        "Resend verification code",
        style: TextStyle(
            color: AppTheme.colors.light.primary,
            decoration: TextDecoration.underline),
      );
    }
    formCols.add(_actionTextForVerification(actionText));

    return formCols;
  }

  Widget _actionTextForVerification(Text actionText) {
    return GestureDetector(
        onTap: () {
          _verifyBloc.add(VerifyResendCodeRequestEvent(email: email));
        },
        child: Container(margin: EdgeInsets.only(top: 24), child: actionText));
  }

  List<Widget> _formForVerification(BuildContext context) {
    return [
      Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Text(
          "Please enter your code below!",
          style: TextStyle(fontSize: 24, color: AppTheme.colors.white),
        ),
      ),
      Container(
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'The verification code was sent to ',
              style: TextStyle(color: AppTheme.colors.white),
              children: <TextSpan>[
                TextSpan(
                    text: email,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.light.primary)),
              ],
            )),
      ),
      VerificationCodeInput(
        keyboardType: TextInputType.number,
        textStyle: TextStyle(
            color: AppTheme.colors.light.primary, fontWeight: FontWeight.bold),
        length: 6,
        autofocus: true,
        onCompleted: (String value) {
          _verifyBloc.add(VerifyRequestEvent(email: email, code: value));
        },
      ),
    ];
  }

  List<Widget> _widgetsForVerificaitonSuccess(BuildContext context,
      VerifySuccessState state) {
    return [
      Icon(
        Icons.verified_user,
        size: 50,
        color: AppTheme.colors.light.primary,
      ),
      Container(
          margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Verified ',
                style: TextStyle(color: AppTheme.colors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: state.email,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.colors.light.primary)),
                  TextSpan(
                      text: " successfully",
                      style: TextStyle(color: AppTheme.colors.white)),
                ],
              ))),
      Text(
        "Tap below to login!",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppTheme.colors.white, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 24.0),
        child: ThemedButtonFactory.create(200, 40, 16, "Login", () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }),
      ),
    ];
  }
}
