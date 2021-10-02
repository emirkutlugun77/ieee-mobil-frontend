// ignore_for_file: unused_element

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:my_app/UI/onboard/onboard.dart';
import 'package:my_app/UI/splash/splash.dart';
import 'package:my_app/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initializeDateFormatting();
  Intl.defaultLocale = 'tr';
  bool? logged =
      prefs.getBool('logged') == null ? false : prefs.getBool('logged');
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");

    // Use this method to automatically convert the push data, in case you gonna use our data standard
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }

  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Color(0xFF376AED)
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
    // Your notification channels go here
  ]);

  // Create the initialization for your desired push service here
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(id: 'white', data: whiteTheme, description: 'white theme'),
        AppTheme(id: 'dark', data: darkTheme, description: 'dark theme'),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) {
            return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),
                title: 'Social',
                theme: ThemeProvider.themeOf(themeContext).data,
                home: logged! ? SplashScreen() : OnBoardingPage());
          },
        ),
      )));
}

// Declared as global, outside of any class
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  // Use this method to automatically convert the push data, in case you gonna use our data standard
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
