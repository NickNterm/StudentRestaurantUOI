import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/models/program.dart';
import 'package:student_restaurant_uoi/pages/all_plates/all_plates_screen.dart';
import 'package:student_restaurant_uoi/pages/calendar/calendar_screen.dart';
import 'package:student_restaurant_uoi/pages/info_screen.dart/info_screen.dart';
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
  PageController controller1 = PageController(viewportFraction: 0.85);
  PageController controller2 = PageController(viewportFraction: 0.85);
  @override
  void initState() {
    super.initState();
    meals = Provider.of<MealController>(context, listen: false).meals;
    lunch = Provider.of<MealController>(context, listen: false).programLunch;
    dinner = Provider.of<MealController>(context, listen: false).programDinner;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller2.jumpToPage(
        dinner.indexWhere((element) => isDateEqual(element.date, DateTime.now())),
      );
      controller1.jumpToPage(
        lunch.indexWhere((element) => isDateEqual(element.date, DateTime.now())),
      );
    });
  }

  bool isDateEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
                  },
                ),
              ),
              Expanded(
                child: MyIconButton(
                  icon: Icons.restaurant,
                  text: "Ολα τα πιάτα",
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AllPlatesScreen()));
                  },
                ),
              )
            ],
          ),
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
