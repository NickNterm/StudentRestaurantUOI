import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpUsDialog extends StatelessWidget {
  const HelpUsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/food.png",
            width: 150,
          ),
          const SizedBox(height: 16),
          const Text(
            "Bοηθησέ μας! Στείλε μας φωτογραφίες απο το φαγητό της λέσχης για να βελτιώσουμε την εφαρμογή μας",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Άκυρο",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (!await launchUrl(Uri.parse("mailto:pamelesxi@gmail.com"))) {
              throw 'Could not launch mail';
            }
          },
          child: const Text("Email"),
        ),
      ],
    );
  }
}
