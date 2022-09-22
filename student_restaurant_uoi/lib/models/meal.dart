class Meal {
  int id;
  String? image;
  String name;

  Meal({
    required this.id,
    required this.image,
    required this.name,
  });

  factory Meal.fromApi(Map data) {
    return Meal(
      id: data["id"],
      image: data["image"],
      name: data["name"],
    );
  }
}
