import 'package:fieldfreshmobile/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/client/orders/order_client.dart';
import 'package:fieldfreshmobile/client/product/product_client.dart';
import 'package:fieldfreshmobile/client/proxy/proxy_client.dart';
import 'package:fieldfreshmobile/client/user/user_client.dart';
import 'package:fieldfreshmobile/feature/home/bloc/home_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/create/bloc/create_order_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/details/bloc/matched_order_details_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/matched_orders/list/bloc/matched_orders_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/pending_buy_order_details_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/pending_orders/details/bloc/pending_sell_order_details_cubit.dart';
import 'package:fieldfreshmobile/feature/orders/summary/order_count/bloc/order_count_badge_cubit.dart';
import 'package:fieldfreshmobile/feature/products/pending/bloc/pending_product_bloc.dart';
import 'package:fieldfreshmobile/feature/products/product_search/bloc/product_search_cubit.dart';
import 'package:fieldfreshmobile/feature/proxy/bloc/proxy_page_cubit.dart';
import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_bloc.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/creation/bloc/user_signup_flow_cubit.dart';
import 'package:fieldfreshmobile/feature/user/signup_flow/verification/bloc/user_signup_verification_bloc.dart';
import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_bloc.dart';
import 'package:fieldfreshmobile/repository/orders_repository.dart';
import 'package:fieldfreshmobile/repository/product_repository.dart';
import 'package:fieldfreshmobile/repository/proxy_repository.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'feature/drawer/bloc/dashboard_bloc.dart';
import 'feature/orders/pending_orders/list/bloc/pending_orders_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => UserSignupVerificationBloc(sl()));

  sl.registerFactory(() => VerifyBloc(sl()));

  sl.registerFactory(() => UserLoginBloc(sl(), sl()));
  sl.registerFactory(() => PendingProductsBloc(sl()));
  sl.registerFactory(() => OrderCountCubit(sl()));
  sl.registerFactory(() => OrderCreationCubit(sl()));
  sl.registerFactory(() => ProductSearchCubit(sl()));
  sl.registerFactory(() => MatchedOrdersCubit(sl()));
  sl.registerFactory(() => PendingBuyOrderDetailsCubit(sl()));
  sl.registerFactory(() => PendingSellOrderDetailsCubit(sl()));
  sl.registerFactory(() => MatchDetailsCubit(sl()));
  sl.registerFactory(() => ProxyCubit(sl()));
  sl.registerFactory(() => UserSignupFlowCubit(sl()));
  sl.registerFactory(() => HomePageCubit());

  sl.registerLazySingleton(() => UserRepository(sl()));
  sl.registerLazySingleton(() => ProxyRepository(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerFactory(() => OrderRepository(sl()));
  sl.registerFactory(() => PendingOrdersCubit(sl()));
  sl.registerFactory(() => NavDrawerBloc());

  sl.registerLazySingleton(() => UserClient(apiClient: sl()));
  sl.registerLazySingleton(() => ProxyClient(apiClient: sl()));
  sl.registerLazySingleton(() => ProductClient(apiClient: sl()));
  sl.registerLazySingleton(() => OrderClient(apiClient: sl()));
  sl.registerLazySingleton(() => FieldFreshApi());
}
