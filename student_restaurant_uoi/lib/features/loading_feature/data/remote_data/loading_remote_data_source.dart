import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';

abstract class LoadingRemoteDataSource {
  // Request the Menu from the server
  Future<MenuModel> getMenu();

  // Request the special days from the server
  Future<List<SpecialDayModel>> getSpecialDays();
}
