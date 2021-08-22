import 'dart:convert';
import 'dart:io';
import 'package:my_app/constants.dart' as constant;
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/Functions/announce.dart';
import 'package:my_app/Functions/auth_functions.dart';
import 'package:my_app/Functions/blog.dart';

import 'package:my_app/Functions/json_converter.dart';

import 'package:my_app/UI/auth/auth_widgets/slidingUpPanel.dart';
import 'package:my_app/UI/home/home.dart';
import 'package:my_app/UI/models/announcement.dart';
import 'package:my_app/UI/models/blogposts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class SignInPage extends StatefulWidget {
  List<Commitee> commiteeList = [];

  List<Event> events = [];
  PageController pageController;

  SignInPage(
      {Key? key,
      required this.pageController,
      required this.commiteeList,
      required this.events})
      : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

bool choosingUni = false;
List<String> departments = [];
User? user;
List<Commitee> commiteeList = [];
dynamic userVariable = '';
String university = '';
String name = '';
String department = '';
String password = '';
String passwordValid = '';
String email = '';
int year = 0;
String surname = '';
String token = '';
List<BlogPost> blogPosts = [];
//USER VARIABLES
List<Announcement> announcements = [];

List<MapEntry<String, dynamic>> universities = [];

List<Post> posts = [];

class _SignInPageState extends State<SignInPage> {
  FlipCardController _flipCardController = FlipCardController();
  PanelController _panelController = PanelController();
  PanelController _panelControllerUni = PanelController();
  late Future future;

  bool logging = false;
  @override
  void initState() {
    super.initState();
    future = parseJsonFromAssets('assets/universities.json')
        .then((value) => value.entries.forEach((element) {
              universities.add(element);
            }));
  }

  bool emailNotValid = false;
  bool succ = false;
  double sliderValue = 0;
  bool obsPass = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: width / 25, horizontal: width / 25),
                    child: FlipCard(
                      flipOnTouch: false,
                      controller: _flipCardController,
                      back: cardBack(width, context, height),
                      front: cardFront(width, context, height),
                    ),
                  ),
                ),
                SlidingWidget(
                    message: userVariable,
                    height: height,
                    panelController: _panelController,
                    backgroundColor:
                        succ ? Colors.green : Theme.of(context).errorColor)
              ],
            );
          }),
    );
  }

  Widget cardFront(double width, BuildContext context, double height) {
    return Container(
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
                  emailNotValid ? 'E-mail Geçersiz veya Kullanımda' : 'Email',
                  style: emailNotValid
                      ? Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Theme.of(context).errorColor)
                      : Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Center(
              child: usernameTextField(context, 'mail'),
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
              child: passwordTextField(context, 'pass'),
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
              child: passwordTextField(context, 'valid'),
            ),
            verticalSpace(height * 1.5),
            GestureDetector(
              onTap: () {
                if (password != '' && passwordValid != '' && email != '') {
                  if (password == passwordValid && password.length > 6) {
                    _flipCardController.toggleCard();
                  } else {
                    openPanel('Parola uzunluğu kısa veya parolalar uyuşmuyor');
                  }
                } else {
                  openPanel('Bilgiler Eksik');
                }
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

  Widget cardBack(double width, BuildContext context, double height) {
    List classes = [
      'Hazırlık',
      '1.Sınıf',
      '2.Sınıf',
      '3.Sınıf',
      '4.Sınıf',
      'Mezun'
    ];

    return Stack(
      children: [
        Container(
          height: height * 1 / 1.5,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(35)),
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
                          usernameTextField(context, 'name')
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
                          usernameTextField(context, 'surname'),
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
                GestureDetector(
                  onTap: () {
                    print('clicked');
                    _panelControllerUni.open();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.0 * height / 1000),
                    child: Center(
                      child: Container(
                        height: height / 20,
                        child: Text(
                          university != ''
                              ? university
                              : 'Okul Seçmek İçin Tıklayın',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                GestureDetector(
                  onTap: () {
                    if (university != '') {
                      _panelControllerUni.open();
                    } else {
                      setState(() {
                        userVariable = 'Lütfen Önce Okul Seçiniz';
                      });
                      _panelController.open();
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => _panelController.close());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.0 * height / 1000),
                    child: Center(
                      child: Container(
                        height: height / 20,
                        child: Text(
                          department != ''
                              ? department
                              : 'Bölüm Seçmek İçin Tıklayın',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                Row(
                  children: [
                    Text('Kayıt olarak ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 13 * height / 1000)),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              if (Platform.isIOS) {
                                return CupertinoAlertDialog(
                                  content: SingleChildScrollView(
                                      child: Text(constant.privacyPolicy)),
                                );
                              } else {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                      child: Text(constant.privacyPolicy)),
                                );
                              }
                            });
                      },
                      child: Text('Kullanıcı Sözleşmesini',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: 13.5 * height / 1000)),
                    ),
                    Text(' kabul ediyorum. ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 13 * height / 1000)),
                  ],
                ),
                verticalSpace(height * 1.3),
                GestureDetector(
                  onTap: () {
                    EasyLoading.show(
                      indicator: LoadingBouncingGrid.square(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                    int year = sliderValue.toInt();
                    Education education = Education(
                        university: university,
                        department: department,
                        year: year);
                    registerUser(name, surname, education, email, password)
                        .then((value) async {
                      if (value.statusCode == 201) {
                        setState(() {
                          succ = true;
                        });
                        String token = jsonDecode(value.body)['token'];

                        print(token);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setBool('logged', true);

                        openPanel('Kayıt Başarılı');
                        getMe(token)
                            .then((value) => user = value)
                            .then((value) => prefs.setString('id', user!.id));
                        getMost5(blogPosts, token, 0).then((value) =>
                            getAnnouncements(token)
                                .then((value) => announcements = value)
                                .then((value) {
                              EasyLoading.dismiss();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                            seenAnnouncements: 0,
                                            announcements: announcements,
                                            events: widget.events,
                                            user: user!,
                                            committees: widget.commiteeList,
                                            blogPosts: blogPosts,
                                            posts: posts,
                                            token: token,
                                            minCommittees: [],
                                            minEvents: [],
                                            minnCerts: [],
                                            userPosts: [],
                                          )));
                            }));
                      } else {
                        EasyLoading.dismiss();
                        openPanel('Bu E-mail Kullanımda');
                        _flipCardController.toggleCard();
                        setState(() {
                          emailNotValid = true;
                          logging = false;
                        });
                      }
                    });
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
        ),
        slidingForSign(
          height,
          width,
        )
      ],
    );
  }

  SlidingUpPanel slidingForSign(double height, double width) {
    return SlidingUpPanel(
        onPanelClosed: () {
          if (university != '') {
            setState(() {
              choosingUni = true;
            });
          }
        },
        slideDirection: SlideDirection.UP,
        minHeight: 0,
        renderPanelSheet: false,
        maxHeight: height / 1.5,
        controller: _panelControllerUni,
        defaultPanelState: PanelState.CLOSED,
        panel: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0 * height / 1000),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _panelControllerUni.close();
                      },
                      child: Icon(FontAwesomeIcons.chevronLeft))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(28.0 * height / 1000),
              child: Container(
                height: height * 1 / 1.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListView.builder(
                    itemCount:
                        choosingUni ? departments.length : universities.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    choosingUni
                                        ? department = departments[index]
                                        : university = universities[index].key;
                                  });
                                  choosingUni
                                      // ignore: unnecessary_statements
                                      ? null
                                      : universities[index]
                                          .value
                                          .forEach((e) => departments.add(e));
                                  _panelControllerUni.close();
                                },
                                child: Text(choosingUni
                                    ? departments[index]
                                    : universities[index].key.toString())),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 1.4,
                              height: 0.5,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ));
  }

  TextField usernameTextField(BuildContext context, String type) {
    return TextField(
      onChanged: (value) {
        switch (type) {
          case ('mail'):
            setState(() {
              email = value;
              if (emailNotValid) {
                emailNotValid = false;
              }
            });

            break;
          case ('name'):
            setState(() {
              name = value;
            });

            break;
          case ('surname'):
            setState(() {
              surname = value;
            });

            break;

          default:
        }
      },
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColorDark)),
      ),
    );
  }

  TextField passwordTextField(BuildContext context, String type) {
    return TextField(
      onChanged: (value) {
        switch (type) {
          case 'pass':
            setState(() {
              password = value;
            });

            break;
          case 'valid':
            setState(() {
              passwordValid = value;
            });

            break;
          default:
        }
      },
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColorDark)),
          suffix: GestureDetector(
            onTap: () {
              if (obsPass) {
                setState(() {
                  obsPass = false;
                });
              } else {
                setState(() {
                  obsPass = true;
                });
              }
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

  void openPanel(String variable) {
    setState(() {
      userVariable = variable;
    });
    _panelController.open();
    Future.delayed(Duration(seconds: 1))
        .then((value) => _panelController.close());
  }

  SizedBox verticalSpace(double height) {
    return SizedBox(
      height: height * 1 / 60,
    );
  }
}
