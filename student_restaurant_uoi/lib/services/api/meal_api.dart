import 'dart:convert';

import 'package:student_restaurant_uoi/constants/url.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/models/program.dart';
import 'package:student_restaurant_uoi/services/interfaces/meal_api_interface.dart';
import 'package:http/http.dart' as http;

class MealApi implements MealApiInterface {
  @override
  void getMeals(Function callback, Function onError) async {
    var url = "$baseUrl/meals";
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<Meal> meals = [];
      for (var meal in data) {
        meals.add(Meal.fromApi(meal));
      }
      callback(meals);
    } else {
      onError();
    }
  }

  @override
  void getProgram(Function callback, Function onError) async {
    var startDate = DateTime.now();
    startDate = DateTime(startDate.year, startDate.month - 2, startDate.day);
    var url = "$baseUrl/program?start_date=01/${startDate.month}/${startDate.year}";
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<Program> program = [];
      for (var day in data) {
        program.add(Program.fromApi(day));
      }
      callback(program);
    } else {
      onError();
    }
  }
}
