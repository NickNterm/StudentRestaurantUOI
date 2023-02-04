import 'package:flutter/material.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/models/program.dart';

import '../models/special_day.dart';

class MealController extends ChangeNotifier {
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  final List<Program> _programDinner = [];
  List<Program> get programDinner => _programDinner;

  final List<Program> _programLunch = [];
  List<Program> get programLunch => _programLunch;

  final List<SpecialDay> _specialDays = [];
  List<SpecialDay> get specialDays => _specialDays;

  void setMeals(List<Meal> meals) {
    _meals = meals;
    notifyListeners();
  }

  void setProgram(List<Program> program) {
    for (var day in program) {
      if (day.type == "dinner") {
        _programDinner.add(day);
      } else {
        _programLunch.add(day);
      }
    }

    notifyListeners();
  }

  void setSpecialDays(List<SpecialDay> specialDays) {
    _specialDays.addAll(specialDays);
    notifyListeners();
  }
}
