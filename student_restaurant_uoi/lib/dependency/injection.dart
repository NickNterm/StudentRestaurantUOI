import 'package:get_it/get_it.dart';
import 'package:student_restaurant_uoi/cubit/in_app_message/in_app_message_cubit.dart';

var sl = GetIt.instance;
void init() {
  sl.registerLazySingleton(
    () => InAppMessageCubit(),
  );
}
