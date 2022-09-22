import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../models/meal.dart';
import '../../../models/program.dart';

class MainDayCard extends StatelessWidget {
  const MainDayCard(
      {Key? key,
      required this.day,
      required this.meals,
      this.showTitle = false})
      : super(key: key);

  final Program day;
  final bool showTitle;
  final List<Meal> meals;
  bool isDateEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 7),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
            ),
          ]),
      child: Stack(
        children: [
          Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   width: double.infinity,
              //   height: 50,
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              //     color: kPrimaryColor,
              //   ),
              //   child: Text(
              //     DateFormat("dd/MM/yy").format(day.date),
              //     style: const TextStyle(
              //         color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
              //   ),
              // ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Κυρίως πιάτα",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      meals
                          .where((element) => element.id == day.mainDish)
                          .first
                          .name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      meals
                          .where((element) => element.id == day.specialDish)
                          .first
                          .name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: kSecondaryColor,
                  height: 0,
                  thickness: 1,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Πρώτο πιάτο",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            meals
                                .where((element) => element.id == day.firstDish)
                                .first
                                .name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: VerticalDivider(
                        color: kSecondaryColor,
                        width: 0,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Συνοδευτικά",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            meals
                                .where((element) => element.id == day.sideDish1)
                                .first
                                .name,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            meals
                                .where((element) => element.id == day.sideDish2)
                                .first
                                .name,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                isDateEqual(day.date,
                        DateTime.now().subtract(const Duration(days: 1)))
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topLeft: Radius.circular(15)),
                          color: Colors.red.withOpacity(0.4),
                        ),
                        child: const Text(
                          "Χθες",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Container(),
                isDateEqual(day.date, DateTime.now())
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topLeft: Radius.circular(15)),
                          color: Colors.green.withOpacity(0.4),
                        ),
                        child: const Text(
                          "Σήμερα",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Container(),
                isDateEqual(
                        day.date, DateTime.now().add(const Duration(days: 1)))
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topLeft: Radius.circular(15)),
                          color: Colors.blue.withOpacity(0.4),
                        ),
                        child: const Text(
                          "Αύριο",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Container(),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(15)),
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                  child: Text(
                    DateFormat("dd/MM/yy").format(day.date),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 0.8,
            top: 10,
            child: showTitle
                ? Text(
                    day.type == "dinner" ? "Δείπνο" : "Μεσημεριανό",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
