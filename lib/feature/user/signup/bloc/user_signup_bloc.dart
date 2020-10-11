import 'dart:async';

import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:fieldfreshmobile/resources/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This is technically a state reducer for the signup page
class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  final UserRepository _userRepository;
  final VerifyBloc _verifyBloc;

  StreamSubscription _verifySubscription;

  UserSignUpBloc(this._userRepository, this._verifyBloc) {
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
  UserSignUpState get initialState => SignUpStateEmpty();

  @override
  void onTransition(Transition<UserSignUpEvent, UserSignUpState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<UserSignUpState> mapEventToState(UserSignUpEvent event) async* {
    if (event is UserSignUpRequestEvent) {
      yield* _mapUserSignUpRequestEventToState(event);
    } else if (event is UserVerificationSuccessEvent) {
      yield* _mapUserVerificationSuccessEventToState(event);
    } else if (event is UserVerificationFailureEvent) {
      yield* _mapUserVerificationFailureEventToState(event);
    }
  }

  Stream<UserSignUpState> _mapUserVerificationSuccessEventToState(
      UserVerificationSuccessEvent event) async* {
    yield SignUpStateVerificationSuccess(event.email);
  }

  Stream<UserSignUpState> _mapUserVerificationFailureEventToState(
      UserVerificationFailureEvent event) async* {
    yield SignUpStateFailed(event.error);
  }

  // This is where the business logic required to interface with the
  // api will go
  Stream<UserSignUpState> _mapUserSignUpRequestEventToState(
      UserSignUpRequestEvent event) async* {
    if (event.password != event.retypedPassword) {
      print(event);
      yield SignUpStateFailed(S.SIGNUP_PASSWORD_RETYPE_NOT_MATCH_ERROR);
    }
    try {
      final result =
      await _userRepository.createUser(event.email, event.password);
      yield SignUpStateVerification(user: result);
    } catch (e) {
      yield SignUpStateFailed("Error creating User!");
    }
  }
}
