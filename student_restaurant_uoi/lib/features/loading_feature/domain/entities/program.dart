import 'package:equatable/equatable.dart';

class Program extends Equatable {
  final DateTime date;
  final String type;
  final int firstDish;
  final int mainDish;
  final int specialDish;
  final int sideDish1;
  final int sideDish2;

  const Program({
    required this.date,
    required this.type,
    required this.firstDish,
    required this.mainDish,
    required this.specialDish,
    required this.sideDish1,
    required this.sideDish2,
  });

  @override
  List<Object?> get props => [
        date,
        type,
        firstDish,
        mainDish,
        specialDish,
        sideDish1,
        sideDish2,
      ];
}
