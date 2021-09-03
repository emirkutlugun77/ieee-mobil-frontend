import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:my_app/Functions/auth_functions.dart';
import 'package:my_app/UI/auth/auth_widgets/slidingUpPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum resetState { INITIAL, CHECKING_TOKEN, CHECKING_PASSWORD }
var current = resetState.INITIAL;

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  ForgotPassword({
    required this.pageController,
  });
  PageController pageController;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

TextEditingController _textEditingController = TextEditingController();
bool checkIfSucceeded = false;
String variable = "";
String buttonText = 'Gönder';
String textFieldDisplay = 'E-Mail';
String token = '';

class _ForgotPasswordState extends State<ForgotPassword> {
  PanelController _panelController = PanelController();
  @override
  void initState() {
    super.initState();
    current = resetState.INITIAL;
  }

  void checkState(var current) {
    switch (current) {
      case (resetState.INITIAL):
        setState(() {
          buttonText = 'Gönder';
          textFieldDisplay = 'E-mail';
        });
        break;
      case (resetState.CHECKING_TOKEN):
        setState(() {
          buttonText = 'Kontrol Et';
          textFieldDisplay = 'Onay Kodu';
        });
        break;
      case (resetState.CHECKING_PASSWORD):
        setState(() {
          buttonText = 'Değiştir';
          textFieldDisplay = 'Yeni Şifre';
        });
        break;
      default:
    }
  }

  String panelText = 'Kod Gönderildi';

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.transparent
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: width / 25, horizontal: width / 25),
            child: SingleChildScrollView(
              child: Container(
                height: height * 1 / 1.5,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: EdgeInsets.all(width * 1 / 9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Şifreni hemen yenile',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ],
                      ),
                      verticalSpace(height / 2),
                      Row(
                        children: [
                          Text(
                            'Mail adresine gelen kodu yaz',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      verticalSpace(height * 2.4),
                      verticalSpace(height / 1.5),
                      Row(
                        children: [
                          Text(
                            textFieldDisplay,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                      verticalSpace(height / 1.5),
                      TextField(
                        controller: _textEditingController,
                        onChanged: (String value) {
                          setState(() {
                            variable = value;
                          });
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark)),
                        ),
                      ),
                      verticalSpace(height * 1.5),
                      GestureDetector(
                        onTap: () async {
                          if (current == resetState.CHECKING_TOKEN) {
                            //res password
                            EasyLoading.show(
                                indicator: LoadingBouncingGrid.square(
                              backgroundColor: Theme.of(context).primaryColor,
                            ));
                            await checkMailToken(variable).then((value) => {
                                  setState(() {
                                    if (value) {
                                      panelText = 'Kod Doğru';
                                      token = _textEditingController.text;
                                      current = resetState.CHECKING_PASSWORD;
                                      checkState(current);
                                    } else {
                                      panelText = 'Kod Doğru Değil';
                                    }
                                    checkIfSucceeded = value;
                                    _textEditingController.clear();
                                  }),
                                  EasyLoading.dismiss(),
                                  _panelController.open(),
                                  Future.delayed(Duration(milliseconds: 1500))
                                      .then((value) => _panelController.close())
                                });
                          } else if (current == resetState.INITIAL) {
                            EasyLoading.show(
                                indicator: LoadingBouncingGrid.square(
                              backgroundColor: Theme.of(context).primaryColor,
                            ));
                            await forgotPassword(variable).then((value) {
                              setState(() {
                                if (value) {
                                  current = resetState.CHECKING_TOKEN;
                                  checkState(current);
                                } else {
                                  panelText = 'E-mail bulunamadı';
                                }
                                checkIfSucceeded = value;
                                _textEditingController.clear();
                              });
                              EasyLoading.dismiss();
                              _panelController.open();
                              Future.delayed(Duration(milliseconds: 1500))
                                  .then((value) => _panelController.close());
                            });
                          } else {
                            EasyLoading.show(
                                indicator: LoadingBouncingGrid.square(
                              backgroundColor: Theme.of(context).primaryColor,
                            ));
                            await resetPassword(
                                    _textEditingController.text, token)
                                .then((value) {
                              checkIfSucceeded = value;
                              if (value) {
                                setState(() {
                                  panelText = 'Şifre başarıyla değiştirildi';
                                });
                                _panelController.open();
                                Future.delayed(Duration(milliseconds: 1500))
                                    .then((value) => _panelController.close())
                                    .then((value) => widget.pageController
                                        .animateToPage(0,
                                            duration:
                                                Duration(milliseconds: 750),
                                            curve: Curves.ease));
                              } else {
                                setState(() {
                                  panelText = 'Şifre uygun değil';
                                });
                                _panelController.open();
                                Future.delayed(Duration(milliseconds: 1500))
                                    .then((value) => _panelController.close());
                              }
                              EasyLoading.dismiss();
                            });
                          }
                        },
                        child: Container(
                          height: height * 1 / 14,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).primaryColor),
                          child: Center(
                            child: Text(
                              buttonText,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(height * 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                current == resetState.INITIAL
                                    ? current = resetState.CHECKING_TOKEN
                                    : current = resetState.INITIAL;

                                checkState(current);
                              });
                            },
                            child: Text(
                              current == resetState.INITIAL
                                  ? 'Kodum Var'
                                  : 'Kodum Yok',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SlidingWidget(
              panelController: _panelController,
              height: height,
              message: panelText,
              backgroundColor: checkIfSucceeded
                  ? Theme.of(context).splashColor
                  : Theme.of(context).errorColor)
        ],
      ),
    );
  }

  SizedBox verticalSpace(double height) {
    return SizedBox(
      height: height * 1 / 60,
    );
  }
}
