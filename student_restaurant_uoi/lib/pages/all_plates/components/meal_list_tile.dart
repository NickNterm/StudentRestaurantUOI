import 'package:flutter/material.dart';

import '../../../dialogs/help_us_dialog.dart';
import '../../../models/meal.dart';

class MealListTile extends StatelessWidget {
  const MealListTile({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) => const HelpUsDialog());
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 3,
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(meal.name),
        ),
      ),
    );
  }
}
