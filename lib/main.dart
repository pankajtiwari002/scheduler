import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/Repo/notificationservice/LocalNotificationService.dart';
import 'package:scheduler/constants.dart';
import 'package:scheduler/firebase_options.dart';
import 'package:scheduler/views/HomePage.dart';
import 'package:scheduler/views/SplashScreen.dart';
import 'package:scheduler/views/authentication/LoginScreen.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Constants.app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    Constants.fcm = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();
    tz.initializeTimeZones();
  } catch (e) {
    log(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scheduler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return LoginScreen();
              }
            }
            return SplashScreen();
          })),
    );
  }
}
