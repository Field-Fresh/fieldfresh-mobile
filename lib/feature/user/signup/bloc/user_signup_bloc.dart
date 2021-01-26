import 'dart:async';

import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:fieldfreshmobile/repository/proxy_repository.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:fieldfreshmobile/resources/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  final UserRepository _userRepository;
  final ProxyRepository _proxyRepository;
  final VerifyBloc _verifyBloc;

  User user = User();
  Proxy proxy = Proxy();
  String _password;

  StreamSubscription _verifySubscription;

  UserSignUpBloc(
      this._userRepository, this._verifyBloc, this._proxyRepository) {
    _verifySubscription = _verifyBloc.listen((verifyState) {
      if (state is SignUpStateVerificationSuccess) {
        if (verifyState is VerifySuccessState) {
          add(UserVerificationSuccessEvent(verifyState.email));
        } else if (verifyState is VerifyFailedState) {
          add(UserVerificationFailureEvent(verifyState.email, verifyState.code,
              error: verifyState.error));
        }
      }
      _password = null;
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
    if (event is UserSignUpSubmittedEvent) {
      yield* _mapUserSignUpToState(event);
    } else if (event is UserVerificationSuccessEvent) {
      yield* _mapUserVerificationSuccessEventToState(event);
    } else if (event is UserVerificationFailureEvent) {
      yield* _mapUserVerificationFailureEventToState(event);
    } else if (event is UserDetailsSubmittedEvent) {
      yield* _mapUserDetailsToState(event);
    } else if (event is ProxyDetailsSubmittedEvent) {
      yield* _mapProxyDetailsToState(event);
    } else if (event is ProxyLocationSubmittedEvent) {
      yield* _mapProxySearchToState(event);
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

  Stream<UserSignUpState> _mapUserSignUpToState(
      UserSignUpSubmittedEvent event) async* {
    if (event.password != event.retypedPassword) {
      print(event);
      yield SignUpStateFailed(S.SIGNUP_PASSWORD_RETYPE_NOT_MATCH_ERROR);
    }
    user.email = event.email;
    _password = event.password;
    yield SignUpStateSuccess(user);
  }

  Stream<UserSignUpState> _mapUserDetailsToState(
      UserDetailsSubmittedEvent event) async* {
    if (event.firstName.isEmpty) {
      yield SignUpStateFailed("Need First Name");
      return;
    }

    if (event.lastName.isEmpty) {
      yield SignUpStateFailed("Need Last Name");
      return;
    }

    if ((event.phoneNumber?.isNotEmpty ?? false) &&
        event.phoneNumber.length > 10) {
      yield SignUpStateFailed("Please enter valid 10 digit phone number.");
      return;
    }

    try {
      user.firstName = event.firstName;
      user.lastName = event.lastName;
      user.phone = event.phoneNumber;
      yield UserDetailsSuccessState(user);
    } catch (e) {
      yield SignUpStateFailed("Error creating User!");
    }
  }

  Stream<UserSignUpState> _mapProxyDetailsToState(
      ProxyDetailsSubmittedEvent event) async* {
    if (event.proxyName.isEmpty) {
      yield SignUpStateFailed("Need Business Name");
      return;
    }

    if (event.proxyDescription.isEmpty) {
      yield SignUpStateFailed("Need Business Description");
      return;
    }

    try {
      proxy.name = event.proxyName;
      proxy.description = event.proxyDescription;
      user = await _userRepository.createUser(user, _password);
      proxy.userId = user.id;
      proxy = await _proxyRepository.createProxy(proxy);
      yield ProxyDetailsSuccessState(proxy);
    } catch (e) {
      yield SignUpStateFailed("Error creating Proxy!");
    }
  }

  Stream<UserSignUpState> _mapProxySearchToState(
      ProxyLocationSubmittedEvent event) async* {
    proxy.streetAddress = event.components.streetAddress;
    proxy.city = event.components.city;
    proxy.province = event.components.province;
    proxy.country = event.components.country;
    proxy.postalCode = event.components.postalCode;
    proxy.lat = event.lat;
    proxy.long = event.long;
  }
}
