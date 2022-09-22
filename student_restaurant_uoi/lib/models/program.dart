class Program {
  DateTime date;
  String type;
  int firstDish;
  int mainDish;
  int specialDish;
  int sideDish1;
  int sideDish2;

  Program({
    required this.date,
    required this.type,
    required this.firstDish,
    required this.mainDish,
    required this.specialDish,
    required this.sideDish1,
    required this.sideDish2,
  });

  factory Program.fromApi(Map data) {
    return Program(
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
