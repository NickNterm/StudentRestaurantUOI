import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/models/program.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

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
  DateTime firstDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    meals = Provider.of<MealController>(context, listen: false).meals;
    programDinner = Provider.of<MealController>(context, listen: false).programDinner;
    programLunch = Provider.of<MealController>(context, listen: false).programLunch;
    firstDay = programDinner[0].date;
  }

  @override
  Widget build(BuildContext context) {
    DateTime lastDay = DateTime.now();
    if (programLunch.last.date.isAfter(lastDay)) {
      lastDay = programLunch.last.date;
    }
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
            firstDay: firstDay,
            focusedDay: focusedDate,
            lastDay: lastDay,
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: ""},
            onFormatChanged: null,
          ),
          programLunch.where((element) => isSameDay(element.date, selectedDate)).toList().isNotEmpty
              ? Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShowDayScreen(
                            meals: meals,
                            lunch: programLunch.firstWhere((element) => isSameDay(element.date, selectedDate)),
                            dinner: programDinner.firstWhere((element) => isSameDay(element.date, selectedDate)),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MainDayCard(
                        day: programLunch.firstWhere((element) => isSameDay(element.date, selectedDate)),
                        meals: meals,
                        minimal: true,
                        showTitle: true,
                      ),
                    ),
                  ),
                )
              : Container(),
          programDinner.where((element) => isSameDay(element.date, selectedDate)).toList().isNotEmpty
              ? Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShowDayScreen(
                            meals: meals,
                            lunch: programLunch.firstWhere((element) => isSameDay(element.date, selectedDate)),
                            dinner: programDinner.firstWhere((element) => isSameDay(element.date, selectedDate)),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MainDayCard(
                        day: programDinner.firstWhere((element) => isSameDay(element.date, selectedDate)),
                        meals: meals,
                        minimal: true,
                        showTitle: true,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      //launch url
                      var url = "https://www.e-food.gr/";
                      if (!await launchUrl(Uri.parse(url))) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 27,
                        vertical: 20,
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 7),
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Η Λέσχη είναι κλειστή αυτήν την ημερομηνία",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Image.asset(
                              "assets/icons/efood.png",
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
