import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.image,
    required super.name,
  });

  factory MealModel.fromJson(Map data) {
    return MealModel(
      id: data["id"],
      image: data["image"],
      name: data["name"],
    );
  }

  factory MealModel.testModel() {
    return const MealModel(
      id: 1,
      image: "Image Url",
      name: "Meal Name",
    );
  }

  Map toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
    };
  }
}
