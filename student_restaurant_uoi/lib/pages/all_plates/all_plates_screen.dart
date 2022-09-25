import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_restaurant_uoi/models/meal.dart';
import 'package:student_restaurant_uoi/providers/meals_controller.dart';

import 'components/meal_list_tile.dart';

class AllPlatesScreen extends StatefulWidget {
  const AllPlatesScreen({Key? key}) : super(key: key);

  @override
  State<AllPlatesScreen> createState() => _AllPlatesScreenState();
}

class _AllPlatesScreenState extends State<AllPlatesScreen> {
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    meals = Provider.of<MealController>(context, listen: false).meals;
    filteredMeals.addAll(meals);
    filteredMeals.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }

  _filterSearchResults(String query) {
    List<Meal> searchList = [];
    searchList.addAll(meals);
    if (query.isNotEmpty) {
      List<Meal> dummyListData = [];

      for (var item in searchList) {
        String doc = item.name.toUpperCase();
        if (doc.contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredMeals.clear();
        filteredMeals.addAll(dummyListData);
        filteredMeals.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
      });
      return;
    } else {
      setState(() {
        filteredMeals.clear();
        filteredMeals.addAll(meals);
        filteredMeals.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextField(
          enableSuggestions: true,
          autofocus: true,
          onChanged: (value) {
            _filterSearchResults(value);
          },
          controller: editingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Αναζήτηση",
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ),
        actions: [
          editingController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        editingController.text = "";
                        _filterSearchResults("");
                      },
                    );
                  },
                )
              : Container(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: filteredMeals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.assignment_late_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Δεν Βρέθηκε πιάτο με αυτό το όνομα",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: filteredMeals.length,
                      itemBuilder: (context, index) {
                        Meal meal = filteredMeals[index];
                        return MealListTile(meal: meal);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
