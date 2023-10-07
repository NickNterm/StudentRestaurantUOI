import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/dish.dart';

class DishModel extends Dish {
  const DishModel({
    required super.id,
    required super.image,
    required super.name,
  });

  factory DishModel.fromJson(Map data) {
    return DishModel(
      id: data["id"],
      image: data["image"],
      name: data["name"],
    );
  }

  factory DishModel.testModel() {
    return const DishModel(
      id: 1,
      image: "Image Url",
      name: "Dish Name",
    );
  }

  factory DishModel.fromEntity(Dish dish) {
    return DishModel(
      id: dish.id,
      image: dish.image,
      name: dish.name,
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
