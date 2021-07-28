import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:my_app/UI/home/home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FlipCardController _flipCardController = FlipCardController();
  double sliderValue = 0;
  bool obsPass = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: width / 25, horizontal: width / 25),
      child: FlipCard(
        flipOnTouch: false,
        controller: _flipCardController,
        back: cardBack(width, context, height),
        front: cardFront(width, context, height),
      ),
    );
  }

  Container cardFront(double width, BuildContext context, double height) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(35)),
      child: Padding(
        padding: EdgeInsets.all(width * 1 / 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Aramıza Katıl',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            verticalSpace(height / 2),
            Row(
              children: [
                Text(
                  'Bilgilerini Girip Hemen Kayıt Ol',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            verticalSpace(height * 1.5),
            Row(
              children: [
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Center(
              child: usernameTextField(context),
            ),
            verticalSpace(height / 1.5),
            Row(
              children: [
                Text(
                  'Parola',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Center(
              child: passwordTextField(context),
            ),
            verticalSpace(height / 1.5),
            Row(
              children: [
                Text(
                  'Parola Onay',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Center(
              child: passwordTextField(context),
            ),
            verticalSpace(height * 1.5),
            GestureDetector(
              onTap: () {
                setState(() {
                  _flipCardController.toggleCard();
                });
              },
              child: Container(
                height: height * 1 / 14,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Devam Et',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
            verticalSpace(height),
          ],
        ),
      ),
    );
  }

  Container cardBack(double width, BuildContext context, double height) {
    List classes = [
      'Hazırlık',
      '1.Sınıf',
      '2.Sınıf',
      '3.Sınıf',
      '4.Sınıf',
      'Mezun'
    ];

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(35)),
      child: Padding(
        padding: EdgeInsets.only(
            top: width * 1 / 16, left: width * 1 / 9, right: width * 1 / 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(height * 1.3),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ad',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      usernameTextField(context)
                    ],
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: SizedBox(),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Soyad',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      usernameTextField(context),
                    ],
                  ),
                  flex: 4,
                ),
              ],
            ),
            verticalSpace(height * 1.5),
            Row(
              children: [
                Text(
                  'Okul',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Center(
              child: usernameTextField(context),
            ),
            verticalSpace(height * 1.5),
            Row(
              children: [
                Text(
                  'Bölüm',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Center(
              child: usernameTextField(context),
            ),
            verticalSpace(height * 1.5),
            Row(
              children: [
                Text(
                  'Sınıf',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Slider(
              value: sliderValue,
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                });
              },
              label: classes[sliderValue.toInt()],
            ),
            verticalSpace(height * 1.3),
            GestureDetector(
              onTap: () {
                /*setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                user: null,
                              )));
                });*/
              },
              child: Container(
                height: height * 1 / 14,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Kayıt Ol',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
            verticalSpace(height),
          ],
        ),
      ),
    );
  }

  TextField usernameTextField(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColorDark)),
      ),
    );
  }

  TextField passwordTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColorDark)),
          suffix: GestureDetector(
            onTapDown: (_) {
              setState(() {
                obsPass = false;
              });
            },
            onTapCancel: () {
              setState(() {
                obsPass = true;
              });
            },
            child: Text(
              'Göster',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          )),
      obscureText: obsPass,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  SizedBox verticalSpace(double height) {
    return SizedBox(
      height: height * 1 / 60,
    );
  }
}
