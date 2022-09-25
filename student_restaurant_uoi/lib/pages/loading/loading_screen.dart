import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/pages/main/main_screen.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';
import 'package:student_restaurant_uoi/services/api/meal_api.dart';

import '../../models/meal.dart';
import '../../models/program.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with MealApi {
  @override
  void initState() {
    super.initState();
    setUp();
  }

  void setUp() async {
    if (await hasNetwork()) {
      getMeals(mealsCallback, onMealError);
    } else {
      const snackBar = SnackBar(
        content: Text(
          'Δεν υπάρχει σύνδεση στο διαδίκτυο',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onMealError() {
    const snackBar = SnackBar(
      content: Text(
        'Υπάρχει κάποιο πρόβλημα στην λήψη των δεδομενων. Προσπαθήστε ξανα αργότερα',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void onProgramError() {
    const snackBar = SnackBar(
      content: Text(
        'Υπάρχει κάποιο πρόβλημα στην λήψη των δεδομενων. Προσπαθήστε ξανα αργότερα',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void mealsCallback(List<Meal> meals) {
    Provider.of<MealController>(context, listen: false).setMeals(meals);
    getProgram(programCallback, onProgramError);
  }

  void programCallback(List<Program> program) {
    Provider.of<MealController>(context, listen: false).setProgram(program);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(height: 150),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33),
          ),
          child: Image.asset(
            "assets/icons/icon.png",
            width: 150,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Pame Lesxi",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        const Spacer(),
        const Text(
          "Για τους φοιτητές που δεν ξέρουν να μαγειρεύουν",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        const SpinKitPulse(color: kPrimaryColor),
        const SizedBox(height: 100)
      ]),
    );
  }
}
