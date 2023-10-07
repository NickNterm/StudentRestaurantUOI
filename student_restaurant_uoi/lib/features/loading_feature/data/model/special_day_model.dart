import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/special_day.dart';

class SpecialDayModel extends SpecialDay {
  const SpecialDayModel({
    required super.name,
    required super.date,
    required super.opacity,
    required super.backgroundImage,
  });

  factory SpecialDayModel.fromJson(Map<String, dynamic> json) {
    return SpecialDayModel(
      name: json["name"],
      date: DateTime.parse(json["date"]),
      opacity: json["opacity"],
      backgroundImage: json["background_image"],
    );
  }

  factory SpecialDayModel.testData() {
    return SpecialDayModel(
      name: "Test",
      date: DateTime.parse("2021-08-10T00:00:00.000000Z"),
      opacity: 0.5,
      backgroundImage: "Image Url",
    );
  }

  Map toJson() {
    return {
      "name": name,
      "date": date.toIso8601String(),
      "opacity": opacity,
      "background_image": backgroundImage,
    };
  }
}
