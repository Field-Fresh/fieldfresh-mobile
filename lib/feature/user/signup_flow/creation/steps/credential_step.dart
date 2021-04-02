import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/step_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef SaveCredentialListener = void Function(
    String email, String password, String confirmPassword);

class CredentialStepView extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final SaveCredentialListener saveCredentialListener;
  final Function backListener;

  final String initialEmail;

  CredentialStepView(
      {Key key,
      @required this.initialEmail,
      @required this.saveCredentialListener,
      @required this.backListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _logoContainer(),
          _infoImageContainer(),
          _userDetailsFormContent(),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
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
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 18),
                    child: ThemedTextField(
                      "Email",
                      initialValue: initialEmail,
                      validationType: ValidationType.email,
                    )),
                ThemedTextField(
                  "Password",
                  validationType: ValidationType.required,
                  obscureText: true,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: ThemedTextField(
                    "Confirm Password",
                    validationType: ValidationType.required,
                    obscureText: true,
                  ),
                ),
                StepNavBar(
                  nextCallback: () {
                    save();
                  },
                  backCallback: () {
                    backListener.call();
                  },
                )
              ],
            ),
          ),
        ),
      );

  void save() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      var email = _formKey.currentState.value['Email'];
      var password = _formKey.currentState.value['Password'];
      var confirmPassword = _formKey.currentState.value['Confirm Password'];
      saveCredentialListener.call(email, password, confirmPassword);
    }
  }
}
