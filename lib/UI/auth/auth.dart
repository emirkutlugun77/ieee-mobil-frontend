import 'package:flutter/material.dart';
import 'package:my_app/UI/auth/login.dart';
import 'package:my_app/UI/auth/sign_in.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool login = true;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.9 / 5,
                  child: Center(
                    child: Image.asset(
                      'images/ieee.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 4.1 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF376AED),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.4 / 5,
                      color: Colors.transparent,
                      child: _headerRow(height, context),
                    ),
                    Container(
                      height: height * 3.6 / 5,
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [LoginPage(), SignInPage()],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _headerRow(double height, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              setState(() {
                login = true;
                _pageController.animateToPage(0,
                    duration: Duration(milliseconds: 365), curve: Curves.ease);

                //PAGE VIEW CONTROLLER
              });
            },
            child: Opacity(
              opacity: login ? 1 : 0.25,
              child: Container(
                height: height * 0.5 / 5,
                child: Center(
                  child: Text(
                    'Giriş Yap',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              setState(() {
                login = false;
                _pageController.animateToPage(1,
                    duration: Duration(milliseconds: 365), curve: Curves.ease);
              });
            },
            child: Opacity(
              opacity: login ? 0.25 : 1,
              child: Container(
                height: height * 0.5 / 5,
                child: Center(
                  child: Text(
                    'Kayıt Ol',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}
