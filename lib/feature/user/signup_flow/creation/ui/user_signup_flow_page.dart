import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/bloc/states.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/bloc/user_signup_flow_cubit.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/steps/credential_step.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/steps/proxy_details_step.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/steps/user_info_step.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/verification/ui/user_verification.dart';
import 'package:fieldfreshmobile/injection_container.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSignupFlow extends StatefulWidget {
  @override
  _UserSignupFlowState createState() => _UserSignupFlowState();
}

class _UserSignupFlowState extends State<UserSignupFlow> {
  UserSignupFlowCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<UserSignupFlowCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _cubit,
      builder: (context, UserSignUpFlowState state) {
        if (state is SignupStepState) {
          return _buildStep(state);
        }

        if (state is Error) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: "Error creating account.",
              desc: state.errorString,
            ).show();
          });
          return _buildStep(state.prevState);
        }

        if (state is SignupSuccess) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserVerificationScreen(email: state.user.email)));
          });
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildStep(SignupStepState state) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildStepContent(state)],
        ),
      );

  Widget buildStepContent(SignupStepState state) {
    if (state is CredentialsStep) {
      return CredentialStepView(
        initialEmail: state.email,
        saveCredentialListener: (email, password, cpassword) {
          _cubit.saveCredentials(email, password, cpassword);
        },
        backListener: () => backStepDelegate(state),
      );
    } else if (state is UserInfoStep) {
      return UserInfoStepView(
        initialFirstName: state.firstName,
        initialLastName: state.lastName,
        initialPhoneNumber: state.phone,
        saveUserInfoListener: (first, last, phone) {
          _cubit.saveUserInfo(first, last, phone);
        },
        backListener: () => backStepDelegate(state),
      );
    } else if (state is ProxyStep) {
      return ProxyDetailsStepView(
          listener: (comp, latlng, name, desc) {
            _cubit.saveProxy(comp, latlng, name, desc);
          },
          back: () => backStepDelegate(state),
          initialProxy: state.proxy);
    }
  }

  void backStepDelegate(SignupStepState state) {
    if (state.step == 0) {
      Navigator.pop(context);
    } else {
      _cubit.back();
    }
  }
}

class UserSignupFlowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: NoGlowSingleChildScrollView(child: UserSignupFlow()),
    )));
  }
}
