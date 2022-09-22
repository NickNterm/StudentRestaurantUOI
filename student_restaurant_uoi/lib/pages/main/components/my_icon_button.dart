import 'package:flutter/material.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.icon,
  }) : super(key: key);

  final String text;
  final Function onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 5),
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
          ),
          const BoxShadow(
            offset: Offset(-5, -5),
            color: Colors.white,
            blurRadius: 7,
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          child: InkWell(
            onTap: () {
              onPress();
            },
            child: Ink(
              color: kWhiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: kSecondaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
