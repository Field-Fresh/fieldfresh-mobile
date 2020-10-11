import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/repository/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/repository/client/user/user_client.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'feature/home/bloc/home_bloc.dart';

final sl = GetIt.instance;

  Future<void> init() async {

    sl.registerFactory(() => UserSignUpBloc(
      sl(),
      sl()
    ));

    sl.registerFactory(() => VerifyBloc(
        sl()
    ));

    sl.registerFactory(() => UserLoginBloc(
        sl(),
        sl()
    ));

    sl.registerFactory(() => BottomNavigationBloc());

    sl.registerLazySingleton(() => UserRepository(sl()));

    sl.registerLazySingleton(() => UserClient(apiClient: sl()));
    sl.registerLazySingleton(() => FieldFreshApi());
  }