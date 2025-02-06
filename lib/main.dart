import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(const DatingApp());
}


Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  print("Получено уведомление: ${message.notification?.title}");
}