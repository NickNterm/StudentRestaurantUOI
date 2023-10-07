import 'package:equatable/equatable.dart';

class SpecialDay extends Equatable {
  final String name;
  final String backgroundImage;
  final double opacity;
  final DateTime date;

  const SpecialDay({
    required this.name,
    required this.date,
    required this.opacity,
    required this.backgroundImage,
  });

  @override
  List<Object?> get props => [
        name,
        date,
        opacity,
        backgroundImage,
      ];
}
