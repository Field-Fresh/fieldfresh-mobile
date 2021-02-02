import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_event.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_state.dart';
import 'package:fieldfreshmobile/feature/user/verify/event/events.dart';
import 'package:fieldfreshmobile/feature/user/verify/state/states.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:fieldfreshmobile/resources/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This is technically a state reducer for the signup page
class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {

  final UserRepository _userRepository;

  VerifyBloc(this._userRepository);

  @override
  VerifyState get initialState => VerifyStateEmpty();

  @override
  void onTransition(Transition<VerifyEvent, VerifyState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) async* {
    if (event is VerifyRequestEvent) {
      yield* _mapVerifyRequestEventToState(event);
    } else if (event is VerifyResendCodeRequestEvent) {
      yield* _mapResendVerifyCodeRequestEventToState(event);
    }
  }

  Stream<VerifyState> _mapResendVerifyCodeRequestEventToState(VerifyResendCodeRequestEvent event) async* {
    try {
      final result = await _userRepository.resendVerification(event.email);
      if (result) {
        yield ResendVerifyCodeSuccessState(event.email);
      } else {
        yield ResendVerifyCodeFailureState(event.email);
      }
    } catch(e) {
      yield ResendVerifyCodeFailureState(event.email);
    }
  }

  Stream<VerifyState> _mapVerifyRequestEventToState(VerifyRequestEvent event) async* {
    try {
      final result = await _userRepository.verifyUserCode(event.email, event.code);
      if (result) {
        yield VerifySuccessState(event.email);
      } else {
        yield VerifyFailedState(event.email, event.code);
      }
    } catch(e) {
      yield VerifyFailedState(event.email, event.code, error: "Invalid Code");
    }
  }
}