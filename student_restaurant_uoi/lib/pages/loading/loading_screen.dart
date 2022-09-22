import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/pages/main/main_screen.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';
import 'package:student_restaurant_uoi/services/api/meal_api.dart';

import '../../models/meal.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with MealApi {
  @override
  void initState() {
    super.initState();
    getMeals(mealsCallback, onMealsError);
  }

  void onMealsError() {
    print("there is an error");
    // TODO here add a snackbar
  }

  void mealsCallback(List<Meal> meals) {
    Provider.of<MealController>(context, listen: false).setMeals(meals);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [SpinKitDualRing(color: kPrimaryColor)]),
    );
  }
}
