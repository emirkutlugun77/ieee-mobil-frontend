import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/UI/event/event_page.dart';
import 'package:my_app/UI/feed/social_feed.dart';
import 'package:my_app/UI/home/QR/qr.dart';

import 'package:my_app/UI/home/home_sections/home1.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/UI/profile/profile.dart';
import 'package:my_app/UI/search/search_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Home1(),
              SocialFeed(),
              SearchBar(),
              Events(),
              ProfilePage()
            ],
          ),
        ),
        bottomNavigationBar: GNav(
            backgroundColor: Colors.white,
            selectedIndex: _currentIndex,
            rippleColor: Colors.grey, // tab button ripple color when pressed
            hoverColor: Colors.grey, // tab button hover color
            haptic: true, // haptic feedback
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(
                  index,
                );
              });
            },
            curve: Curves.ease, // tab animation curves
            duration: Duration(milliseconds: 365), // tab animation duration

            color: Colors.grey[800], // unselected icon color
            activeColor:
                Theme.of(context).primaryColor, // selected icon and text color
            iconSize: 30, // tab button icon size
            // selected tab background color
            padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15 *
                    MediaQuery.of(context).size.width /
                    500), // navigation bar padding
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.hashtag,
                text: 'Pano',
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.layerGroup,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ]));
  }
}
