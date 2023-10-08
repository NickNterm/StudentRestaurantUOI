import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_restaurant_uoi/core/constants/keys.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';

abstract class LoadingLocalDataSource {
  // Cache the Menu in the local database
  Future<MenuModel> cacheMenu(MenuModel menuModel);

  // Get the meals fro mthe local database
  Future<MenuModel> getMenu();
}

class LoadingLocalDataSourceImpl extends LoadingLocalDataSource {
  SharedPreferences sharedPreferences;

  LoadingLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<MenuModel> cacheMenu(MenuModel menuModel) async {
    await sharedPreferences.setString(
      menuKey,
      jsonEncode(menuModel.toJson()),
    );
    return menuModel;
  }

  @override
  Future<MenuModel> getMenu() async {
    final menu = sharedPreferences.getString(menuKey);
    if (menu != null && menu.isNotEmpty) {
      return MenuModel.fromJson(
        jsonDecode(menu),
      );
    } else {
      throw Exception();
    }
  }
}
