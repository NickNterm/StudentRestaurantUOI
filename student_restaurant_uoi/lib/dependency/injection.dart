import 'package:get_it/get_it.dart';
import 'package:student_restaurant_uoi/dependency/core_injection.dart';
import 'package:student_restaurant_uoi/dependency/loading_injection.dart';
import 'package:student_restaurant_uoi/dependency/main_injection.dart';

var sl = GetIt.instance;

void init() {
  initCore();
  initMain();
  initLoading();
}
