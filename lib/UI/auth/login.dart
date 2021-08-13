import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/Functions/user.dart';
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/auth/auth.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:my_app/Functions/auth_functions.dart';

import 'package:my_app/UI/auth/auth_widgets/slidingUpPanel.dart';
import 'package:my_app/UI/home/home.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/user.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  List<Commitee> commiteeList = [];
  List<BlogPost> blogPosts = [];
  List<Event> events = [];
  PageController pageController;
  LoginPage(
      {Key? key,
      required this.commiteeList,
      required this.blogPosts,
      required this.pageController,
      required this.events})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

User? user;
bool logging = false;
dynamic userVariable = 'Lütfen Bekleyin';
String email = '';
String password = '';
String token = '';

//USER VARIABLES
List<Post> userPosts = [];
List<MinEvent> minEvents = [];
List<MinCertificate> minnCerts = [];
List<MinCommittee> minCommittees = [];

//USER VARIABLES
class _LoginPageState extends State<LoginPage> {
  bool obsPass = true;
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        opacity: 0,
        inAsyncCall: logging,
        progressIndicator: LoadingBouncingGrid.circle(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: width / 25, horizontal: width / 25),
                child: Container(
                  height: height / 1.5,
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
                            setState(() {
                              logging = true;
                            });
                            var result = await loginUser(email, password);

                            if (!(result is User)) {
                              userVariable = result;
                              _panelController.open();

                              Future.delayed(Duration(seconds: 1))
                                  .then((value) {
                                print('panel');
                                setState(() {
                                  logging = false;
                                });
                                _panelController.close();
                              });
                            } else {
                              user = result;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('logged', true);
                              prefs.setString('id', user!.id);
                              token = prefs.getString('token')!;
                              getUserData(user!.id, minCommittees, minnCerts,
                                      minEvents, userPosts, token)
                                  .then((value) =>
                                      getAllPosts(posts).then((value) {
                                        setState(() {
                                          logging = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage(
                                                      events: events,
                                                      user: user!,
                                                      committees:
                                                          widget.commiteeList,
                                                      blogPosts:
                                                          widget.blogPosts,
                                                      posts: posts,
                                                      token: token,
                                                      minCommittees:
                                                          minCommittees,
                                                      minEvents: minEvents,
                                                      minnCerts: minnCerts,
                                                      userPosts: userPosts,
                                                    )));
                                      }));
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
                            GestureDetector(
                              onTap: () {
                                widget.pageController.animateToPage(2,
                                    duration: Duration(milliseconds: 750),
                                    curve: Curves.ease);
                              },
                              child: Text(
                                ' Burdan Yenile',
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
              message: userVariable,
              backgroundColor: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
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
