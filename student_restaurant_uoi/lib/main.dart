import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/pages/loading/loading_screen.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MealController>(
          create: (context) => MealController(),
        ),
      ],
      child: MaterialApp(
        title: 'Student Restaurant UOI',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
