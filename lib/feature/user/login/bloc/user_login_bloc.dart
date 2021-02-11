import 'dart:async';

import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_event.dart';
import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_state.dart';
import 'package:fieldfreshmobile/feature/user/login/event/events.dart';
import 'package:fieldfreshmobile/feature/user/login/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:fieldfreshmobile/util/auth.dart';
import 'package:fieldfreshmobile/util/user_singleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This is technically a state reducer for the signup page
class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserRepository _userRepository;
  final VerifyBloc _verifyBloc;

  StreamSubscription verifySubscription;

  UserLoginBloc(this._userRepository, this._verifyBloc) : super(UserLoginStateEmpty()) {
    verifySubscription = _verifyBloc.listen((verifyState) {
      if (verifyState is VerifySuccessState) {
        add(UserVerificationSuccessEvent(email: verifyState.email));
      } else if (verifyState is VerifyFailedState) {
        add(UserVerificationFailureEvent(
            email: verifyState.email,
            code: verifyState.code,
            error: verifyState.error));
      }
    });
  }

  @override
  void onTransition(Transition<UserLoginEvent, UserLoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<UserLoginState> mapEventToState(UserLoginEvent event) async* {
    if (event is UserLoginRequestEvent) {
      yield* _mapUserLoginRequestEventToState(event);
    }

    if (event is UserVerificationSuccessEvent) {}
    if (event is UserVerificationFailureEvent) {}
    if (event is UserReturnToLoginEvent) {
      yield* _mapUserReturnTosLoginEventToState(event);
    }
  }

  Stream<UserLoginState> _mapUserReturnTosLoginEventToState(
      UserReturnToLoginEvent event) async* {
    yield UserLoginStateEmpty();
  }

  // This is where the business logic required to interface with the
  // api will go
  Stream<UserLoginState> _mapUserLoginRequestEventToState(
      UserLoginRequestEvent event) async* {
    try {
      final result = await _userRepository.login(event.email, event.password);
      if (result.verificationRequired) {
        yield UserLoginStateVerificationRequired(event.email);
      } else if (result.user != null && result.tokens != null) {
        // TODO the singleton pattern might not be the best to use here
        AuthUtil.storeAuth(result.tokens);
        UserSingleton().updateUser(result.user);
        yield UserLoginStateSuccess(result.user);
      }
    } catch (e) {
      yield UserLoginStateFailed("Incorrect credentials!");
    }
  }
}
