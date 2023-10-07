import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/program.dart';

class ProgramModel extends Program {
  const ProgramModel({
    required super.date,
    required super.type,
    required super.firstDish,
    required super.mainDish,
    required super.specialDish,
    required super.sideDish1,
    required super.sideDish2,
  });
  factory ProgramModel.fromApi(Map data) {
    return ProgramModel(
      date: DateTime.parse(data["date"]),
      type: data["meal_type"],
      firstDish: data["first_dish"],
      mainDish: data["main_dish"],
      specialDish: data["special_dish"],
      sideDish1: data["side_dish1"],
      sideDish2: data["side_dish2"],
    );
  }
}
