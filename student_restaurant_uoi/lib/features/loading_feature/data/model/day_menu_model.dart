import 'package:student_restaurant_uoi/features/loading_feature/data/model/meal_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/day_menu.dart';

class DayMenuModel extends DayMenu {
  const DayMenuModel({
    required super.dinner,
    required super.lunch,
    required super.date,
  });

  factory DayMenuModel.fromJson(Map<String, dynamic> json) {
    return DayMenuModel(
      dinner: MealModel.fromJson(json['dinner']),
      lunch: MealModel.fromJson(json['lunch']),
      date: DateTime.parse(json['date']),
    );
  }

  factory DayMenuModel.testData() {
    return DayMenuModel(
      dinner: MealModel.testData(),
      lunch: MealModel.testData(),
      date: DateTime.parse("2021-08-10T00:00:00.000Z"),
    );
  }

  factory DayMenuModel.fromEntity(DayMenu dayMenu) {
    return DayMenuModel(
      dinner: MealModel.fromEntity(dayMenu.dinner),
      lunch: MealModel.fromEntity(dayMenu.lunch),
      date: dayMenu.date,
    );
  }

  Map toJson() {
    return {
      'dinner': MealModel.fromEntity(dinner).toJson(),
      'lunch': MealModel.fromEntity(lunch).toJson(),
      'date': date.toIso8601String(),
    };
  }
}
