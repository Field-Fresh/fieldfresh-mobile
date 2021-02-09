import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_bloc.dart';
import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/repository/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/repository/client/product/product_client.dart';
import 'package:fieldfreshmobile/repository/client/proxy/proxy_client.dart';
import 'package:fieldfreshmobile/repository/client/user/user_client.dart';
import 'package:fieldfreshmobile/repository/product_repository.dart';
import 'package:fieldfreshmobile/repository/proxy_repository.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'feature/drawer/bloc/dashboard_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => UserSignUpBloc(sl(), sl(), sl()));

  sl.registerFactory(() => VerifyBloc(sl()));

  sl.registerFactory(() => UserLoginBloc(sl(), sl()));
  sl.registerFactory(() => PendingProductsBloc(sl()));

  sl.registerLazySingleton(() => UserRepository(sl()));
  sl.registerLazySingleton(() => ProxyRepository(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerFactory(() => NavDrawerBloc());

  sl.registerLazySingleton(() => UserClient(apiClient: sl()));
  sl.registerLazySingleton(() => ProxyClient(apiClient: sl()));
  sl.registerLazySingleton(() => ProductClient(apiClient: sl()));
  sl.registerLazySingleton(() => FieldFreshApi());
}
