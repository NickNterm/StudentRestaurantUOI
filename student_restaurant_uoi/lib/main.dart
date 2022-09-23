import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';
import 'package:student_restaurant_uoi/pages/loading/loading_screen.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        title: 'Pame Lesxi UOI',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme.of(context).copyWith(
            centerTitle: true,
            elevation: 7,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey.withOpacity(0.4),
          ),
          scaffoldBackgroundColor: kWhiteColor,
          primaryColor: kPrimaryColor,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
