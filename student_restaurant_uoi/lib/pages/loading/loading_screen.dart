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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        const SizedBox(height: 100),
        Image.asset(
          "assets/icons/icon.png",
          width: 150,
        ),
        const Spacer(),
        const SpinKitPianoWave(color: kSecondaryColor),
        const SizedBox(height: 100)
      ]),
    );
  }
}
