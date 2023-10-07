import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final int id;
  final String? image;
  final String name;

  const Meal({
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        name,
      ];
}
