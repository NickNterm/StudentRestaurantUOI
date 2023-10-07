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

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      date: DateTime.parse(json["date"]),
      type: json["meal_type"],
      firstDish: json["first_dish"],
      mainDish: json["main_dish"],
      specialDish: json["special_dish"],
      sideDish1: json["side_dish1"],
      sideDish2: json["side_dish2"],
    );
  }

  factory ProgramModel.testData() {
    return ProgramModel(
      date: DateTime.parse("2021-08-10T00:00:00.000000Z"),
      type: "meal",
      firstDish: 1,
      mainDish: 2,
      specialDish: 3,
      sideDish1: 4,
      sideDish2: 5,
    );
  }

  Map toJson() {
    return {
      "date": date.toIso8601String(),
      "meal_type": type,
      "first_dish": firstDish,
      "main_dish": mainDish,
      "special_dish": specialDish,
      "side_dish1": sideDish1,
      "side_dish2": sideDish2,
    };
  }
}
