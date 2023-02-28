import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/models/special_day.dart';
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
  late Database db;
  @override
  void initState() {
    super.initState();
    setUp();
  }

  void setUp() async {
    if (await hasNetwork()) {
      createTableIfNotExist();
      getMeals(mealsCallback, onMealError);
    } else {
      var databasesPath = await getDatabasesPath();
      String dbpath = path.join(databasesPath, 'pamelesxi.db');
      db = await openDatabase(dbpath, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE meals (id INTEGER PRIMARY KEY, name TEXT, image TEXT);');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS program (id INTEGER PRIMARY KEY, date TEXT, meal_type TEXT, first_dish INTEGER, main_dish INTEGER, special_dish INTEGER, side_dish1 INTEGER, side_dish2 INTEGER);');
      });

      List<Map> meals = await db.rawQuery("SELECT * FROM meals");
      List<Meal> mealList = [];
      for (var meal in meals) {
        mealList.add(Meal.fromApi(meal));
      }
      if (!mounted) return;
      Provider.of<MealController>(context, listen: false).setMeals(mealList);

      List<Map> program = await db.rawQuery("SELECT * FROM program");
      List<Program> programList = [];
      for (var day in program) {
        programList.add(Program.fromApi(day));
      }
      if (!mounted) return;
      Provider.of<MealController>(context, listen: false)
          .setProgram(programList);
      await db.close();
      if (meals.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1)).then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MainScreen(),
            ),
          ),
        );
      } else {
        const snackBar = SnackBar(
          content: Text(
            'Δεν υπάρχει σύνδεση στο διαδίκτυο',
          ),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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

  void createTableIfNotExist() async {
    var databasesPath = await getDatabasesPath();
    String dbpath = path.join(databasesPath, 'pamelesxi.db');

    Database database = await openDatabase(dbpath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE meals (id INTEGER PRIMARY KEY, name TEXT, image TEXT);');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS program (id INTEGER PRIMARY KEY, date TEXT, meal_type TEXT, first_dish INTEGER, main_dish INTEGER, special_dish INTEGER, side_dish1 INTEGER, side_dish2 INTEGER);');
    });
    db = database;
    await db.execute("DROP TABLE meals");
    await db.execute("DROP TABLE program");
    await db.execute(
        'CREATE TABLE meals (id INTEGER PRIMARY KEY, name TEXT, image TEXT);');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS program (id INTEGER PRIMARY KEY, date TEXT, meal_type TEXT, first_dish INTEGER, main_dish INTEGER, special_dish INTEGER, side_dish1 INTEGER, side_dish2 INTEGER);');
  }

  void onProgramError() {
    const snackBar = SnackBar(
      content: Text(
        'Υπάρχει κάποιο πρόβλημα στην λήψη των δεδομενων. Προσπαθήστε ξανα αργότερα',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void mealsCallback(List<Meal> meals) async {
    Provider.of<MealController>(context, listen: false).setMeals(meals);
    await db.transaction((txn) async {
      for (var meal in meals) {
        await txn.rawInsert(
          "INSERT INTO meals (name, image) VALUES ('${meal.name}', '${meal.image}');",
        );
      }
    });
    getProgram(programCallback, onProgramError);
  }

  void programCallback(List<Program> program) async {
    Provider.of<MealController>(context, listen: false).setProgram(program);
    await db.transaction((txn) async {
      for (var day in program) {
        await txn.rawInsert(
          "INSERT INTO program(date, meal_type, first_dish, main_dish, special_dish, side_dish1, side_dish2) VALUES('${day.date}', '${day.type}', ${day.firstDish}, ${day.mainDish}, ${day.specialDish}, ${day.sideDish1}, ${day.sideDish2})",
        );
      }
    });
    getSpecial(specialCallback, onSpecialError);
  }

  void specialCallback(List<SpecialDay> special) async {
    Provider.of<MealController>(context, listen: false).setSpecialDays(special);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(),
        ),
      ),
    );
  }

  void onSpecialError() {
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
