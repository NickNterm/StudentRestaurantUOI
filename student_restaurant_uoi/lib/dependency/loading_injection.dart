import 'package:student_restaurant_uoi/dependency/injection.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/local_data/loading_local_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/remote_data/loading_remote_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/repository/loading_repository_impl.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/repository/loading_repository.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/use_case/get_menu_use_case.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/use_case/get_special_days_use_case.dart';
import 'package:student_restaurant_uoi/features/loading_feature/presentation/bloc/menu/menu_bloc.dart';

void initLoading() {
  // Bloc
  sl.registerLazySingleton(
    () => MenuBloc(
      getMenuUseCase: sl(),
    ),
  );

  // Use Case
  sl.registerLazySingleton(
    () => GetMenuUseCase(
      loadingRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetSpecialDayUseCase(
      loadingRepository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<LoadingRepository>(
    () => LoadingRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<LoadingRemoteDataSource>(
    () => LoadingRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<LoadingLocalDataSource>(
    () => LoadingLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
}
