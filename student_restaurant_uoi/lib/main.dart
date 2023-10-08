import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:student_restaurant_uoi/core/constants/colors.dart';
import 'package:student_restaurant_uoi/dependency/injection.dart';
import 'package:student_restaurant_uoi/features/loading_feature/presentation/bloc/menu/menu_bloc.dart';
import 'package:student_restaurant_uoi/features/loading_feature/presentation/bloc/special_days/special_days_bloc.dart';
import 'package:student_restaurant_uoi/features/loading_feature/presentation/page/loading_page.dart';
import 'package:student_restaurant_uoi/features/main_feature/presentation/cubit/in_app_message/in_app_message_cubit.dart';
import 'package:student_restaurant_uoi/firebase_options.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance.logEvent(
    name: 'message_received_on_background',
    parameters: message.data,
  );
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'id',
    'mainNotificationChunnel', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  int id = (DateTime.now().microsecond.toInt() +
      DateTime.now().millisecond.toInt() +
      DateTime.now().second.toInt());
  flutterLocalNotificationsPlugin.show(
    id,
    message.data["title"],
    message.data["body"],
    NotificationDetails(
      android: AndroidNotificationDetails(
        message.data["title"],
        channel.name,
        channelDescription: channel.description,
        icon: 'notification_icon',
      ),
    ),
  );
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late FirebaseAnalytics analytics;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // String? token = await messaging.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    analytics.logEvent(
      name: 'message_received_in_app',
      parameters: message.data,
    );
    sl<InAppMessageCubit>().showInAppMessage(message);
  });

  await messaging.subscribeToTopic('all');

  analytics.logEvent(
    name: 'app_opened',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InAppMessageCubit>(
          create: (context) => sl<InAppMessageCubit>(),
        ),
        BlocProvider<MenuBloc>(
          create: (context) => sl<MenuBloc>(),
        ),
        BlocProvider<SpecialDaysBloc>(
          create: (context) => sl<SpecialDaysBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Pame Lesxi UOI',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          appBarTheme: AppBarTheme.of(context).copyWith(
            centerTitle: true,
            elevation: 7,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey.withOpacity(0.4),
          ),
        ),
        home: const LoadingPage(),
      ),
    );
  }
}
