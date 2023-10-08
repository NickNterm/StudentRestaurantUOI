import 'package:student_restaurant_uoi/dependency/injection.dart';
import 'package:student_restaurant_uoi/features/main_feature/presentation/cubit/in_app_message/in_app_message_cubit.dart';

void initMain() {
  // Bloc
  sl.registerLazySingleton(
    () => InAppMessageCubit(),
  );
}
