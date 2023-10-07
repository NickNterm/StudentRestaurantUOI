import 'package:equatable/equatable.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/meal.dart';

class DayMenu extends Equatable {
  final Meal dinner;
  final Meal lunch;
  final DateTime date;

  const DayMenu({
    required this.dinner,
    required this.lunch,
    required this.date,
  });

  @override
  List<Object?> get props => [
        dinner,
        lunch,
        date,
      ];
}
