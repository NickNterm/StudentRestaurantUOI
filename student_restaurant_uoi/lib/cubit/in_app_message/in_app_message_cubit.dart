import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

class InAppMessageCubit extends Cubit<RemoteMessage?> {
  InAppMessageCubit() : super(null);

  void showInAppMessage(RemoteMessage message) {
    emit(message);
  }
}
