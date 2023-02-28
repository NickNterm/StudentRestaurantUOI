class SpecialDay {
  final String name;
  final String backgroundImage;
  final double opacity;
  final DateTime date;

  SpecialDay({
    required this.name,
    required this.date,
    required this.opacity,
    required this.backgroundImage,
  });

  factory SpecialDay.fromApi(Map<String, dynamic> data) {
    return SpecialDay(
      name: data['name'],
      date: DateTime.parse(data['date']),
      opacity: data['opacity'],
      backgroundImage: data['background_image'],
    );
  }
}
