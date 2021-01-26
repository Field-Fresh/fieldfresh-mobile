import 'package:fieldfreshmobile/feature/user/login/ui/login_page.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/proxy_details.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_details.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_signup.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_verification.dart';
import 'package:fieldfreshmobile/feature/user/verify/ui/verify_form.dart';
import 'package:fieldfreshmobile/widgets/no_glow_single_child_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fieldfreshmobile/widgets/ThemedButtonFactory.dart';
import 'package:fieldfreshmobile/widgets/ThemedTextFieldFactory.dart';
import 'package:fieldfreshmobile/theme/app_theme.dart';

import '../../../../injection_container.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<UserSignUpBloc>(),
          )
        ],
        child: UserSignUpScreen(),
        ));
  }
}
