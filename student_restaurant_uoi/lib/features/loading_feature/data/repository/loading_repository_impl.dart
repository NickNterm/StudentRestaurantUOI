import 'package:dartz/dartz.dart';
import 'package:student_restaurant_uoi/core/failure/failure.dart';
import 'package:student_restaurant_uoi/core/network_info/network_info.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/local_data/loading_local_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/remote_data/loading_remote_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/repository/loading_repository.dart';

class LoadingRepositoryImpl extends LoadingRepository {
  // Here we will have to check for the Network Connection
  // If there is Network then fetch the data from the data base online.
  // also we will cache data that we fetched so that it will open in case the app starts without internet connection
  // if there is no Network then fetch the data from the cache
  // if there is no data in the cache then show an error message to the user
  // This Idea goes to all the requests

  NetworkInfo networkInfo;
  LoadingRemoteDataSource remoteDataSource;
  LoadingLocalDataSource localDataSource;

  LoadingRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, MenuModel>> getMenu() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMenu();

        try {
          localDataSource.cacheMenu(result);
        } catch (_) {}
        return Right(result);
      } catch (_) {
        try {
          final result = await localDataSource.getMenu();
          return Right(result);
        } catch (_) {
          return const Left(CacheFailure());
        }
      }
    } else {
      try {
        final localMeals = await localDataSource.getMenu();
        return Right(localMeals);
      } catch (_) {
        return const Left(NetworkFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<SpecialDayModel>>> getSpecialDays() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getSpecialDays();
        return Right(result);
      } catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
