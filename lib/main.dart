import 'package:flutter/material.dart';

import 'package:my_app/UI/onboard/onboard.dart';
import 'package:my_app/UI/splash/splash.dart';
import 'package:my_app/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<MapEntry<String, dynamic>> universities = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? logged =
      prefs.getBool('logged') == null ? false : prefs.getBool('logged');
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Color(0xFF376AED)
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      theme: whiteTheme,
      home: logged! ? SplashScreen() : OnBoardingPage()));
}
