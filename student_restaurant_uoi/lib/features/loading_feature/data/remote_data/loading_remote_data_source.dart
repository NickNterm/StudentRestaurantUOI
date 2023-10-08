import 'dart:convert';

import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/urls.dart';

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
        Uri.parse('$baseUrl/ioannina/menu/'),
        headers: <String, String>{
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Content-Type': 'application/json; charset=utf-8',
        },
      );
      if (response.statusCode == 200) {
        Map data = jsonDecode(utf8.decode(response.bodyBytes));
        return MenuModel.fromJson(data);
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<List<SpecialDayModel>> getSpecialDays() async {
    var response = await client.get(
      Uri.parse('$baseUrl/ioannina/specialDays/'),
      headers: <String, String>{
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<SpecialDayModel> specialDays = [];
      for (var day in data) {
        specialDays.add(SpecialDayModel.fromJson(day));
      }
      return specialDays;
    } else {
      throw Exception();
    }
  }
}
