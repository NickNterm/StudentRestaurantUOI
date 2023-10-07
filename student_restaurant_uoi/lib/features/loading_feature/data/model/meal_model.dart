import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.image,
    required super.name,
  });

  factory MealModel.fromApi(Map data) {
    return MealModel(
      id: data["id"],
      image: data["image"],
      name: data["name"],
    );
  }
}
