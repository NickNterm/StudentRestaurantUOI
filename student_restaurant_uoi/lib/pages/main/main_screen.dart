import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/cubit/in_app_message/in_app_message_cubit.dart';
import 'package:student_restaurant_uoi/dependency/injection.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/models/program.dart';
import 'package:student_restaurant_uoi/pages/all_plates/all_plates_screen.dart';
import 'package:student_restaurant_uoi/pages/calendar/calendar_screen.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';

import 'components/main_day_card.dart';
import 'components/my_icon_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Meal> meals;
  late List<Program> lunch;
  late List<Program> dinner;
  late StreamSubscription notificationListener;
  PageController controller1 = PageController(viewportFraction: 0.85);
  PageController controller2 = PageController(viewportFraction: 0.85);
  PageController controller3 = PageController(viewportFraction: 0.85);
  @override
  void initState() {
    super.initState();
    notificationListener = sl<InAppMessageCubit>().stream.listen((state) {
      if (state == null) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(state.data['title']),
          content: Text(state.data['body']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });
    meals = Provider.of<MealController>(context, listen: false).meals;
    lunch = Provider.of<MealController>(context, listen: false).programLunch;
    dinner = Provider.of<MealController>(context, listen: false).programDinner;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).size.width > 600) {
        controller3.jumpToPage(
          dinner.indexWhere(
              (element) => isDateEqual(element.date, DateTime.now())),
        );
      } else {
        controller2.jumpToPage(
          dinner.indexWhere(
              (element) => isDateEqual(element.date, DateTime.now())),
        );
        controller1.jumpToPage(
          lunch.indexWhere(
              (element) => isDateEqual(element.date, DateTime.now())),
        );
      }
    });
  }

  bool isDateEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pame Lesxi UOI"),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (_) => const InfoScreen(),
        //         ),
        //       );
        //     },
        //     icon: const Icon(Icons.info_outline_rounded),
        //   )
        //  ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyIconButton(
                  icon: Icons.calendar_month,
                  text: "Ημερολόγιο",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CalendarScreen()));
                  },
                ),
              ),
              Expanded(
                child: MyIconButton(
                  icon: Icons.restaurant,
                  text: "Ολα τα πιάτα",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AllPlatesScreen()));
                  },
                ),
              )
            ],
          ),
          if (MediaQuery.of(context).size.width > 600)
            RowListWidget(
              controller3: controller3,
              lunch: lunch,
              dinner: dinner,
              meals: meals,
            )
          else
            UpListWidget(
              controller1: controller1,
              lunch: lunch,
              meals: meals,
              controller2: controller2,
              dinner: dinner,
            ),
        ],
      ),
    );
  }
}

class RowListWidget extends StatelessWidget {
  const RowListWidget({
    super.key,
    required this.controller3,
    required this.lunch,
    required this.dinner,
    required this.meals,
  });

  final PageController controller3;
  final List<Program> lunch;
  final List<Program> dinner;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller3,
        itemCount: lunch.length,
        itemBuilder: (context, index) {
          var launchDay = lunch[index];
          var dinnerDay = dinner[index];
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Μεσημεριανό",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: MainDayCard(day: launchDay, meals: meals),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Βραδινό",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: MainDayCard(day: dinnerDay, meals: meals),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class UpListWidget extends StatelessWidget {
  const UpListWidget({
    super.key,
    required this.controller1,
    required this.lunch,
    required this.meals,
    required this.controller2,
    required this.dinner,
  });

  final PageController controller1;
  final List<Program> lunch;
  final List<Meal> meals;
  final PageController controller2;
  final List<Program> dinner;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Text(
            "Μεσημεριανό",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller1,
              itemCount: lunch.length,
              itemBuilder: (context, index) {
                var day = lunch[index];
                return MainDayCard(day: day, meals: meals);
              },
            ),
          ),
          const Text(
            "Δείπνο",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller2,
              itemCount: dinner.length,
              itemBuilder: (context, index) {
                var day = dinner[index];
                return MainDayCard(day: day, meals: meals);
              },
            ),
          ),
        ],
      ),
    );
  }
}
