import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/models/program.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/meal.dart';
import '../main/components/main_day_card.dart';
import '../show_day/show_day_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  List<Meal> meals = [];
  List<Program> programDinner = [];
  List<Program> programLunch = [];
  @override
  void initState() {
    super.initState();
    meals = Provider.of<MealController>(context, listen: false).meals;
    programDinner =
        Provider.of<MealController>(context, listen: false).programDinner;
    programLunch =
        Provider.of<MealController>(context, listen: false).programLunch;
  }

  @override
  Widget build(BuildContext context) {
    DateTime lastDay = DateTime.now();

    lastDay = DateTime(lastDay.year, lastDay.month + 1, 0);
    return Scaffold(
      appBar: AppBar(title: const Text("Ημερολόγιο")),
      body: Column(
        children: [
          TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                selectedDate = selectedDay;
                focusedDate = selectedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: kSecondaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            firstDay: DateTime.parse("2022-09-01"),
            focusedDay: focusedDate,
            lastDay: lastDay,
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: ""},
            onFormatChanged: null,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowDayScreen(
                      meals: meals,
                      lunch: programLunch.firstWhere(
                          (element) => isSameDay(element.date, selectedDate)),
                      dinner: programDinner.firstWhere(
                          (element) => isSameDay(element.date, selectedDate)),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MainDayCard(
                  day: programLunch.firstWhere(
                      (element) => isSameDay(element.date, selectedDate)),
                  meals: meals,
                  minimal: true,
                  showTitle: true,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowDayScreen(
                      meals: meals,
                      lunch: programLunch.firstWhere(
                          (element) => isSameDay(element.date, selectedDate)),
                      dinner: programDinner.firstWhere(
                          (element) => isSameDay(element.date, selectedDate)),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MainDayCard(
                  day: programDinner.firstWhere(
                      (element) => isSameDay(element.date, selectedDate)),
                  meals: meals,
                  minimal: true,
                  showTitle: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10)
          // Expanded(
          //   child: PageView.builder(
          //     controller: controller,
          //     itemCount: 2,
          //     itemBuilder: (context, index) {
          //       if (index == 0) {
          //         return MainDayCard(
          //           day: programLunch.firstWhere(
          //               (element) => isSameDay(element.date, selectedDate)),
          //           meals: meals,
          //           showTitle: true,
          //         );
          //       } else {
          //         return MainDayCard(
          //           day: programDinner.firstWhere(
          //               (element) => isSameDay(element.date, selectedDate)),
          //           meals: meals,
          //           showTitle: true,
          //         );
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
