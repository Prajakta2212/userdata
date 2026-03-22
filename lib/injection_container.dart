// injection_container.dart
import 'package:get_it/get_it.dart';
import 'core/network/api_service.dart';
import 'core/utils/cache_helper.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/domain/repositories/user_repository.dart';
import 'features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => CacheHelper());

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl(), sl()));

  sl.registerFactory(() => UserBloc(sl()));
}