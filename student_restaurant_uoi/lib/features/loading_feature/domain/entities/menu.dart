import 'package:equatable/equatable.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/day_menu.dart';

class Menu extends Equatable {
  final String university;
  final List<DayMenu> daysMenu;

  const Menu({
    required this.university,
    required this.daysMenu,
  });

  @override
  List<Object?> get props => [
        university,
        daysMenu,
      ];
}
