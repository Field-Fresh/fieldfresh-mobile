import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_state.dart';
import 'package:fieldfreshmobile/feature/user/verify/event/events.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
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
        bloc: _verifyBloc,
        builder: (context, state) {
          return Column(
            children: _formFromState(context, state),
            crossAxisAlignment: CrossAxisAlignment.center,
          );
        });
  }

  List<Widget> _formFromState(BuildContext context, VerifyState state) {
    final List<Widget> formCols = [];

    if (state is VerifyFailedState) {
      formCols.add(Text(
        state.error,
        style: TextStyle(color: Colors.red),
      ));
    }


    if (state is VerifySuccessState) {
      formCols.addAll(_widgetsForVerificaitonSuccess(context, state));
    } else {
      formCols.addAll(_formForVerification(context));
    }

    Text actionText;
    if (state is ResendVerifyCodeFailureState) {
      actionText = Text(
        "Failed to resend verification code",
        style: TextStyle(
            color: Colors.red, decoration: TextDecoration.underline),
      );
    } else if (state is ResendVerifyCodeSuccessState) {
      actionText = Text(
        "Successfully resent verification code",
        style: TextStyle(
            color: Colors.green, decoration: TextDecoration.underline),
      );
    } else {
      actionText = Text(
        "Resend verification code",
        style: TextStyle(
            color: Colors.black87, decoration: TextDecoration.underline),
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
      child: Container(
          margin: EdgeInsets.only(top: 24),
          child: actionText
      )
    );
  }

  List<Widget> _formForVerification(BuildContext context) {
    return [
      Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Text(
          "Please enter your code below!",
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Text(
          "The verification code was sent to $email",
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
      VerificationCodeInput(
        keyboardType: TextInputType.number,
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
        color: Colors.green,
      ),
      Container(
        margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
        child: Text(
          "Verified ${state.email} successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        "Tap below to login!",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: EdgeInsets.only(top: 8.0),
        child: RaisedButton(
          color: Colors.deepOrange,
          child: Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            // Go back to login. MAy have to change this if we can get to signup from elsewhere
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
    ];
  }
}
