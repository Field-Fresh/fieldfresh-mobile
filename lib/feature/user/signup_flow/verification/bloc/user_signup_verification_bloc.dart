import 'dart:async';

import 'package:fieldfreshmobile/feature/user/signup_flow/verification/bloc/user_signup_verification_event.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_signup_verification_state.dart';

class UserSignupVerificationBloc extends Bloc<UserSignUpEvent, UserSignupVerificationState> {
  final VerifyBloc _verifyBloc;

  StreamSubscription _verifySubscription;

  UserSignupVerificationBloc(this._verifyBloc) : super(SignUpStateEmpty()) {
    _verifySubscription = _verifyBloc.listen((verifyState) {
      if (state is SignUpStateVerificationSuccess) {
        if (verifyState is VerifySuccessState) {
          add(UserVerificationSuccessEvent(verifyState.email));
        } else if (verifyState is VerifyFailedState) {
          add(UserVerificationFailureEvent(verifyState.email, verifyState.code,
              error: verifyState.error));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _verifySubscription.cancel();
    return super.close();
  }

  @override
  void onTransition(Transition<UserSignUpEvent, UserSignupVerificationState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<UserSignupVerificationState> mapEventToState(UserSignUpEvent event) async* {
    if (event is UserVerificationSuccessEvent) {
      yield* _mapUserVerificationSuccessEventToState(event);
    } else if (event is UserVerificationFailureEvent) {
      yield* _mapUserVerificationFailureEventToState(event);
    }
  }

  Stream<UserSignupVerificationState> _mapUserVerificationSuccessEventToState(
      UserVerificationSuccessEvent event) async* {
    yield SignUpStateVerificationSuccess(event.email);
  }

  Stream<UserSignupVerificationState> _mapUserVerificationFailureEventToState(
      UserVerificationFailureEvent event) async* {
    yield SignUpStateFailed(event.error);
  }
}
