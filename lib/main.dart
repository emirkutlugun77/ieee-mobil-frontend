import 'package:flutter/material.dart';

import 'package:my_app/UI/onboard/onboard.dart';
import 'package:my_app/UI/splash/splash.dart';
import 'package:my_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool logged = prefs.getBool('logged')!;

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: whiteTheme,
      home: OnBoardingPage())); //logged ? SplashScreen() : OnBoardingPage()));
}
