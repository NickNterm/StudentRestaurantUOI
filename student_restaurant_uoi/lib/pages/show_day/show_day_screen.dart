import 'package:flutter/material.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/models/program.dart';
import 'package:student_restaurant_uoi/pages/main/components/main_day_card.dart';

class ShowDayScreen extends StatelessWidget {
  const ShowDayScreen(
      {Key? key,
      required this.meals,
      required this.lunch,
      required this.dinner})
      : super(key: key);
  final List<Meal> meals;
  final Program lunch;
  final Program dinner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Μενού")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: "lunch",
                child: MainDayCard(day: lunch, meals: meals),
              ),
            ),
            Expanded(
              child: Hero(
                tag: "dinner",
                child: MainDayCard(day: dinner, meals: meals),
              ),
            )
          ],
        ),
      ),
    );
  }
}
