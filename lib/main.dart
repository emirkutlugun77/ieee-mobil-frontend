import 'package:flutter/material.dart';

import 'package:my_app/UI/onboard/onboard.dart';
import 'package:my_app/UI/splash/splash.dart';
import 'package:my_app/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? logged =
      prefs.getBool('logged') == null ? false : prefs.getBool('logged');
  String? themeId = prefs.getString('theme');
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
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),
                title: 'Social',
                theme: ThemeProvider.themeOf(themeContext).data,
                home: logged! ? SplashScreen() : OnBoardingPage());
          },
        ),
      )));
}
