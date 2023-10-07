import 'package:equatable/equatable.dart';

class Dish extends Equatable {
  final int id;
  final String? image;
  final String name;

  const Dish({
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
