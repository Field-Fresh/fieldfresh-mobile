

import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_event.dart';
import 'package:flutter/foundation.dart';

class VerifyRequestEvent extends VerifyEvent {
  final String email;
  final String code;

  VerifyRequestEvent(
      {
        @required this.email,
        @required this.code
      }
    ) : super([email, code]);

  @override
  String toString() => 'VerifyRequestEvent';
}

class VerifyResendCodeRequestEvent extends VerifyEvent {
  final String email;

  VerifyResendCodeRequestEvent(
      {
        @required this.email
      }
      ) : super([email]);

  @override
  String toString() => 'VerifyResendCodeRequestEvent';
}