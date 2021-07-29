import 'package:flutter/material.dart';
import 'package:my_app/Functions/auth_functions.dart';
import 'package:my_app/Functions/committee.dart';
import 'package:my_app/UI/home/home.dart';
import 'package:my_app/UI/home/home_widgets/carousel_card.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

User? user;
List<Commitee> commiteeList = [];
dynamic userVariable = '';
String email = '';
String password = '';

class _LoginPageState extends State<LoginPage> {
  bool obsPass = true;
  PanelController _panelController = PanelController();
  late Future future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = getAllCommittees(commiteeList);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: width / 25, horizontal: width / 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35)),
                    child: Padding(
                      padding: EdgeInsets.all(width * 1 / 9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hoşgeldin',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ],
                          ),
                          verticalSpace(height / 2),
                          Row(
                            children: [
                              Text(
                                'Hesabınızla hemen giriş yapın',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          verticalSpace(height * 2.4),
                          Row(
                            children: [
                              Text(
                                'Kullanıcı Adı',
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                          verticalSpace(height / 1.5),
                          Center(
                            child: usernameTextField(
                              context,
                            ),
                          ),
                          verticalSpace(height * 1.5),
                          Row(
                            children: [
                              Text(
                                'Şifre',
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                          verticalSpace(height / 1.5),
                          Center(
                            child: passwordTextField(context),
                          ),
                          verticalSpace(height * 1.5),
                          GestureDetector(
                            onTap: () async {
                              var result = await loginUser(email, password);
                              setState(() {
                                if (!(result is User)) {
                                  userVariable = result;
                                } else {
                                  user = result;
                                }
                              });
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                List<ComiteeCard> widgetOfCommittees =
                                    commiteeList
                                        .map((e) => ComiteeCard(commitee: e))
                                        .toList();

                                if (user != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage(
                                                user: user!,
                                                committees: widgetOfCommittees,
                                              )));
                                } else {
                                  //opens error panel
                                  _panelController.open();
                                  Future.delayed(Duration(seconds: 1)).then(
                                      (value) => _panelController.close());
                                }
                              } else {
                                print('err');
                              }
                            },
                            child: Container(
                              height: height * 1 / 14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                child: Text(
                                  'Giriş Yap',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                          ),
                          verticalSpace(height),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Şifreni mi Unuttun?',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                ' Burdan Yenile',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SlidingUpPanel(
                  boxShadow: [
                    BoxShadow(blurRadius: 0, color: Colors.transparent)
                  ],
                  color: Colors.transparent,
                  controller: _panelController,
                  defaultPanelState: PanelState.CLOSED,
                  minHeight: 0,
                  maxHeight: height * 1 / 8,
                  panel: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Container(
                      height: height * 1 / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).errorColor,
                      ),
                      child: Center(
                        child: Text(
                          userVariable,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  TextField usernameTextField(BuildContext context) {
    return TextField(
      onChanged: (String value) {
        setState(() {
          email = value;
        });
      },
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColorDark)),
      ),
    );
  }

  TextField passwordTextField(
    BuildContext context,
  ) {
    return TextField(
      onChanged: (String value) {
        setState(() {
          password = value;
        });
      },
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
