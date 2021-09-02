import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_app/UI/auth/auth.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Theme.of(context).backgroundColor,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: "Social Mobilde!", //"Social Artık Mobilde!",
          body:
              "Socialdaki birçok özellik artık mobil uygulamamızda, isterseniz komiteler hakkında bilgi alın, isterseniz makale okuyun!",
          //"Socialdaki birçok özellik artık mobil uygulamamızda, isterseniz komiteler hakkında bilgi alın, isterseniz makale okuyun!",
          image: Image.asset('images/ob1.png'),
          decoration: pageDecoration.copyWith(
              imagePadding: EdgeInsets.only(bottom: 32),
              pageColor: Theme.of(context).backgroundColor),
        ),
        PageViewModel(
          title: "QR Kodlar",
          body:
              "Etkinlik oturumlarına katılırken QR kodunuzu uygulamadan okutabilirsiniz!  ",
          image: Image.asset('images/ob3.png'),
          decoration: pageDecoration.copyWith(
              imagePadding: EdgeInsets.only(bottom: 40),
              pageColor: Theme.of(context).backgroundColor),
        ),
        PageViewModel(
          title: "Sertifikalar",
          body:
              "Artık sertifikalarınız cebinizde! \n Social mobil ile dilediğiniz zaman sertifikalarınıza bakabilirsiniz",
          image: Image.asset('images/ob2.png'),
          decoration: pageDecoration.copyWith(
              imagePadding: EdgeInsets.only(bottom: 18),
              pageColor: Theme.of(context).backgroundColor),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: Text('Geç', style: Theme.of(context).textTheme.bodyText1),
      next: const Icon(Icons.arrow_forward),
      done: Text('Giriş', style: Theme.of(context).textTheme.bodyText1),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
