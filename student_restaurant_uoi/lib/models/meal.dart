class Meal {
  DateTime date;
  String type;
  String firstDish;
  String mainDish;
  String specialDish;
  String sideDish1;
  String sideDish2;

  Meal({
    required this.date,
    required this.type,
    required this.firstDish,
    required this.mainDish,
    required this.specialDish,
    required this.sideDish1,
    required this.sideDish2,
  });

  factory Meal.fromApi(Map data) {
    return Meal(
      date: data["date"],
      type: data["meal_type"],
      firstDish: data["first_dish"],
      mainDish: data["main_dish"],
      specialDish: data["special_dish"],
      sideDish1: data["side_dish1"],
      sideDish2: data["side_dish2"],
    );
  }
}
