import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_restaurant_uoi/core/constants/colors.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/day_menu.dart';

class MainDayCard extends StatelessWidget {
  const MainDayCard({
    Key? key,
    required this.day,
    required this.type,
    this.minimal = false,
    this.showTitle = false,
  }) : super(key: key);

  final DayMenu day;

  final bool showTitle;
  final bool minimal;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(specialDay.backgroundImage),
            opacity: specialDay.opacity,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 7),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
            ),
          ]),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
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
                      'Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      'Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: !minimal,
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.grey.withOpacity(0.4),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'firstDish.name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 30),
                              child: VerticalDivider(
                                color: Colors.grey.withOpacity(0.4),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'sideDish1.name',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    'sideDish2.name',
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
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(20),
                          ),
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
                            bottomRight: Radius.circular(11),
                            topLeft: Radius.circular(21),
                          ),
                          color: Colors.green.withOpacity(0.3),
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
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(20),
                          ),
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
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(20),
                    ),
                    color: kSecondaryColor.withOpacity(0.3),
                  ),
                  child: Text(
                    DateFormat("dd/MM/yy").format(day.date),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 0.8,
            top: 5,
            child: showTitle
                ? Text(
                    type == "dinner" ? "Δείπνο" : "Μεσημεριανό",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                : Container(),
          ),
          Positioned(
              bottom: 6,
              child: Text(
                'specialDish.name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              )),
        ],
      ),
    );
  }

  bool isDateEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isDayEqual(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month;
  }
}
