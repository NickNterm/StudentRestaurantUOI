import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:student_restaurant_uoi/constants/url.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/services/interfaces/meal_api_interface.dart';
import 'package:http/http.dart' as http;

class MealApi implements MealApiInterface {
  @override
  void getMeals(Function callback, Function onError) async {
    var url = baseUrl;
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Meal> meals = [];
      for (var meal in data) {
        meals.add(Meal.fromApi(meal));
      }
      callback(meals);
    } else {
      onError();
    }
  }
}
