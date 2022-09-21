import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_restaurant_uoi/constants/colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
// TODO make the api call here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [SpinKitDualRing(color: kPrimaryColor)]),
    );
  }
}
