import 'dart:convert';

import 'package:student_restaurant_uoi/constants/url.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:http/http.dart' as http;

abstract class LoadingRemoteDataSource {
  // Request the Menu from the server
  Future<MenuModel> getMenu();

  // Request the special days from the server
  Future<List<SpecialDayModel>> getSpecialDays();
}

class LoadingRemoteDataSourceImpl extends LoadingRemoteDataSource {
  http.Client client;
  LoadingRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<MenuModel> getMenu() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/ioannina/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ApiKey': '123456789',
        },
      );
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        return MenuModel.fromJson(data);
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<List<SpecialDayModel>> getSpecialDays() {
    // TODO: implement getSpecialDays
    throw UnimplementedError();
  }
}
