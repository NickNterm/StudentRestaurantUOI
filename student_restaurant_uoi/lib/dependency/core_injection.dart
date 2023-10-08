import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_restaurant_uoi/core/network_info/network_info.dart';
import 'package:student_restaurant_uoi/dependency/injection.dart';

Future<void> initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
    ),
  );
}
