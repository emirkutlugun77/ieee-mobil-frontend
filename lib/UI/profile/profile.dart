import 'package:flutter/material.dart';

import 'package:line_icons/line_icon.dart';
import 'package:my_app/UI/home/QR/qr.dart';
import 'package:my_app/UI/onboard/onboard.dart';

import 'package:my_app/UI/profile/profile_widgets/profile_container.dart';
import 'package:my_app/UI/profile/profile_widgets/profile_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PageController _pageController = PageController(initialPage: 0);
  int checkNum = 0;
  static const List<String> choices = <String>[
    'Ayarlar',
    'Çıkış Yap',
    'QR Kodum'
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xFFE6EAF1).withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.only(top: 58.0 * height / 900),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profil',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    icon: LineIcon.horizontalEllipsis(),
                    itemBuilder: (BuildContext context) {
                      return choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: GestureDetector(
                              onTap: () async {
                                if (choice == 'QR Kodum') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QrCode()));
                                } else if (choice == 'Çıkış Yap') {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('logged', false);
                                  prefs.setString('id', '');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OnBoardingPage()));
                                }
                              },
                              child: Text(choice)),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 1 / 40,
            ),
            ProfileContainer(width: width, height: height),
            SizedBox(
              height: height * 1 / 40,
            ),
            Flexible(
              child: PageView(
                controller: _pageController,
                onPageChanged: (pageNum) {
                  setState(() {
                    checkNum = pageNum;
                  });
                },
                children: [
                  ProfileSection(
                      height: height,
                      width: width,
                      title: 'Katıldığım Etkinlikler',
                      child: SizedBox()),
                  ProfileSection(
                      height: height,
                      width: width,
                      title: 'Komite Üyeliklerim',
                      child: SizedBox()),
                  ProfileSection(
                      height: height,
                      width: width,
                      title: 'Kazandığım Sertifikalar',
                      child: SizedBox()),
                  ProfileSection(
                      height: height,
                      width: width,
                      title: 'Pano Yazılarım',
                      child: SizedBox())
                ],
              ),
            ),
            bottomIndicator(width, height)
          ],
        ),
      ),
    );
  }

  Container bottomIndicator(double width, double height) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 1 / 3),
        child: Container(
          color: Colors.white,
          height: height * 1 / 28,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Container(
                      width: width * 1 / 30,
                      height: width * 1 / 30,
                      decoration: BoxDecoration(
                          color: checkNum == index
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).bottomAppBarColor,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  )),
        ),
      ),
    );
  }
}
