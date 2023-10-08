import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_restaurant_uoi/core/constants/colors.dart';
import 'package:student_restaurant_uoi/dependency/injection.dart';
import 'package:student_restaurant_uoi/features/loading_feature/presentation/bloc/menu/menu_bloc.dart';
import 'package:student_restaurant_uoi/features/loading_feature/presentation/bloc/special_days/special_days_bloc.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double animatedScale = 10;
  StreamSubscription? menuSubscription;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        animatedScale = 1;
      });
      sl<MenuBloc>().add(GetMenuEvent());
      menuSubscription = sl<MenuBloc>().stream.listen((event) {
        if (event is MenuLoaded) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
      sl<SpecialDaysBloc>().add(GetSpecialDays());
    });
  }

  @override
  void dispose() {
    super.dispose();
    menuSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 50.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "PAME LESXI",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Για τους φοιτητές που δεν ξέρουν να μαγειρεύουν",
                  style: TextStyle(
                    fontSize: 19,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                SpinKitPouringHourGlass(
                  color: kPrimaryColor,
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
          Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 1000),
              scale: animatedScale,
              curve: Curves.easeOutSine,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/icons/icon.png',
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
