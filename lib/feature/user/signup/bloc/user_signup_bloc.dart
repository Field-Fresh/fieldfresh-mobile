import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/feature/user/signup/event/events.dart';
import 'package:fieldfreshmobile/feature/user/signup/state/states.dart';
import 'package:fieldfreshmobile/resources/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This is technically a state reducer for the signup page
class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {

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
    }
  }

  // This is where the business logic required to interface with the
  // api will go
  Stream<UserSignUpState> _mapUserSignUpRequestEventToState(UserSignUpRequestEvent event) async* {
    if (event.password != event.retypedPassword) {
      print(event);
      yield SignUpStateFailed(S.SIGNUP_PASSWORD_RETYPE_NOT_MATCH_ERROR);
    }
  }

}