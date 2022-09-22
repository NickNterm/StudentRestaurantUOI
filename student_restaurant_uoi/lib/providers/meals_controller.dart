import 'package:flutter/material.dart';
import 'package:student_restaurant_uoi/models/meal.dart';

class MealController extends ChangeNotifier {
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  void setMeals(List<Meal> meals) {
    _meals = meals;
    notifyListeners();
  }
}
