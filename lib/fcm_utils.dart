import 'package:firebase_messaging/firebase_messaging.dart';

class FCMUtils {
  void listenFirebaseMessages() {
    FirebaseMessaging.onMessage.listen((event) {
      final RemoteMessage message = event;
      print(message.notification?.title ?? 'Empty title');
      print(message.notification?.body ?? 'Empty body');
      print(message.data);
    });
  }

  void sendMessage(String title, String body) {
    FirebaseMessaging.instance.sendMessage(to: '');
  }
}