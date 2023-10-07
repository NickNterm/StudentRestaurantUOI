import 'package:student_restaurant_uoi/features/loading_feature/data/model/dish_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.firstDish,
    required super.mainDish,
    required super.specialDish,
    required super.sideDish1,
    required super.sideDish2,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      firstDish: DishModel.fromJson(json["first_dish"]),
      mainDish: DishModel.fromJson(json["main_dish"]),
      specialDish: DishModel.fromJson(json["special_dish"]),
      sideDish1: DishModel.fromJson(json["side_dish1"]),
      sideDish2: DishModel.fromJson(json["side_dish2"]),
    );
  }

  factory MealModel.testData() {
    return MealModel(
      firstDish: DishModel.testModel(),
      mainDish: DishModel.testModel(),
      specialDish: DishModel.testModel(),
      sideDish1: DishModel.testModel(),
      sideDish2: DishModel.testModel(),
    );
  }

  factory MealModel.fromEntity(Meal meal) {
    return MealModel(
      firstDish: DishModel.fromEntity(meal.firstDish),
      mainDish: DishModel.fromEntity(meal.mainDish),
      specialDish: DishModel.fromEntity(meal.specialDish),
      sideDish1: DishModel.fromEntity(meal.sideDish1),
      sideDish2: DishModel.fromEntity(meal.sideDish2),
    );
  }

  Map toJson() {
    return {
      "first_dish": DishModel.fromEntity(firstDish).toJson(),
      "main_dish": DishModel.fromEntity(mainDish).toJson(),
      "special_dish": DishModel.fromEntity(specialDish).toJson(),
      "side_dish1": DishModel.fromEntity(sideDish1).toJson(),
      "side_dish2": DishModel.fromEntity(sideDish2).toJson(),
    };
  }
}
