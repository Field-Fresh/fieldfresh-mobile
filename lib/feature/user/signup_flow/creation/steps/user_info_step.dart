import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/widgets/step_nav_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef SaveUserInfoListener = void Function(
    String firstName, String lastName, String phoneNumber);

class UserInfoStepView extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final SaveUserInfoListener saveUserInfoListener;
  final Function backListener;

  final String initialFirstName;
  final String initialLastName;
  final String initialPhoneNumber;

  UserInfoStepView(
      {Key key,
      @required this.initialFirstName,
      @required this.initialLastName,
      @required this.initialPhoneNumber,
      @required this.saveUserInfoListener,
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
                      "First Name",
                      initialValue: initialFirstName,
                      validationType: ValidationType.required,
                    )),
                ThemedTextField(
                  "Last Name",
                  initialValue: initialLastName,
                  validationType: ValidationType.required,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: ThemedTextField(
                    "Phone Number (optional)",
                    initialValue: initialPhoneNumber,
                    type: TextInputType.number,
                    maxLength: 10,
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
      var fName = _formKey.currentState.value['First Name'];
      var lName = _formKey.currentState.value['Last Name'];
      var pNumber = _formKey.currentState.value['Phone Number'];
      saveUserInfoListener.call(fName, lName, pNumber);
    }
  }
}
