import 'package:dartz/dartz.dart';
import 'package:student_restaurant_uoi/core/failure/failure.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';

// This is the Repository For Loading Feature
abstract class LoadingRepository {
  // This function reads the Menu and gives it to the app
  Future<Either<Failure, MenuModel>> getMenu();

  // This function read the Special Days and gives it to the app as a list of SpecialDayModel
  Future<Either<Failure, List<SpecialDayModel>>> getSpecialDays();
}
