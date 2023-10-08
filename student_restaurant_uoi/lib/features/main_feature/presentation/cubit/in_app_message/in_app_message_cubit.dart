import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InAppMessageCubit extends Cubit<RemoteMessage?> {
  InAppMessageCubit() : super(null);

  void showInAppMessage(RemoteMessage message) {
    emit(message);
  }
}
