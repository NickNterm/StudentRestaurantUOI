import 'package:student_restaurant_uoi/features/loading_feature/data/model/day_menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/day_menu.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/menu.dart';

class MenuModel extends Menu {
  const MenuModel({
    required super.university,
    required super.daysMenu,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    List<DayMenu> daysMenu = [];
    for (var dayMenu in json['days_menu']) {
      daysMenu.add(DayMenuModel.fromJson(dayMenu));
    }
    return MenuModel(
      university: json['university'],
      daysMenu: daysMenu,
    );
  }

  Map toJson() {
    List<Map> daysMenu = [];
    for (var dayMenu in this.daysMenu) {
      daysMenu.add(DayMenuModel.fromEntity(dayMenu).toJson());
    }
    return {
      'university': university,
      'days_menu': daysMenu,
    };
  }

  factory MenuModel.testData() {
    return MenuModel(
      university: "University Of Ioannina",
      daysMenu: [
        DayMenuModel.testData(),
      ],
    );
  }
}
