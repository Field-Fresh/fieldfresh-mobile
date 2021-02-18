import 'package:fieldfreshmobile/feature/home/bloc/home_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/create/buy/bloc/create_buy_order_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/summary/order_count/bloc/order_count_badge_cubit.dart';
import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_bloc.dart';
import 'package:fieldfreshmobile/feature/products/product_search/bloc/product_search_cubit.dart';
import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/repository/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/repository/client/orders/order_client.dart';
import 'package:fieldfreshmobile/repository/client/product/product_client.dart';
import 'package:fieldfreshmobile/repository/client/proxy/proxy_client.dart';
import 'package:fieldfreshmobile/repository/client/user/user_client.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
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
  sl.registerFactory(() => OrderCountCubit(sl()));
  sl.registerFactory(() => BuyOrderCreationCubit(sl()));
  sl.registerFactory(() => ProductSearchCubit(sl()));
  sl.registerFactory(() => HomePageCubit());

  sl.registerLazySingleton(() => UserRepository(sl()));
  sl.registerLazySingleton(() => ProxyRepository(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerFactory(() => OrderRepository(sl()));
  sl.registerFactory(() => NavDrawerBloc());

  sl.registerLazySingleton(() => UserClient(apiClient: sl()));
  sl.registerLazySingleton(() => ProxyClient(apiClient: sl()));
  sl.registerLazySingleton(() => ProductClient(apiClient: sl()));
  sl.registerLazySingleton(() => OrderClient(apiClient: sl()));
  sl.registerLazySingleton(() => FieldFreshApi());
}
