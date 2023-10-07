import 'package:equatable/equatable.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/dish.dart';

class Meal extends Equatable {
  final Dish firstDish;
  final Dish mainDish;
  final Dish specialDish;
  final Dish sideDish1;
  final Dish sideDish2;

  const Meal({
    required this.firstDish,
    required this.mainDish,
    required this.specialDish,
    required this.sideDish1,
    required this.sideDish2,
  });

  @override
  List<Object?> get props => [
        firstDish,
        mainDish,
        specialDish,
        sideDish1,
        sideDish2,
      ];
}
