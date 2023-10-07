import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';

abstract class LoadingLocalDataSource {
  // Cache the Menu in the local database
  Future<MenuModel> cacheMenu(MenuModel menuModel);

  // Get the meals fro mthe local database
  Future<MenuModel> getMenu();
}
