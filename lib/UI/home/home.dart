import 'package:flutter/material.dart';
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/article/articles.dart';

import 'package:my_app/UI/event/event_page.dart';
import 'package:my_app/UI/feed/social_feed.dart';

import 'package:my_app/UI/home/home_sections/home1.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/UI/models/announcement.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/profile/profile.dart';
import 'package:my_app/UI/search/search_page.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage(
      {required this.seenAnnouncements,
      required this.announcements,
      required this.user,
      required this.committees,
      required this.blogPosts,
      required this.events,
      required this.posts,
      required this.token,
      required this.minCommittees,
      required this.minEvents,
      required this.minnCerts,
      required this.userPosts});
  int seenAnnouncements;
  List<Announcement> announcements;
  User user;
  String token;
  List<Commitee> committees;
  List<BlogPost> blogPosts;
  List<Event> events;
  List<Post> posts;
  List<MinEvent> minEvents;
  List<MinCertificate> minnCerts;
  List<MinCommittee> minCommittees;
  List<Post> userPosts;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Event> events = [];
  int _currentIndex = 0;
  PageController _pageController = PageController();

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.token);
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
              Home1(
                  seenAnnouncements: widget.seenAnnouncements,
                  announcements: widget.announcements,
                  user: widget.user,
                  committees: widget.committees,
                  blogPosts: widget.blogPosts),
              SocialFeed(
                posts: widget.posts.reversed.toList(),
                token: widget.token,
              ),
              Articles(
                token: widget.token,
                blogPosts: widget.blogPosts,
              ),
              Events(
                user: widget.user,
                events: widget.events,
              ),
              ProfilePage(
                  user: widget.user,
                  minCommittees: widget.minCommittees,
                  minEvents: widget.minEvents,
                  minnCerts: widget.minnCerts,
                  userPosts: widget.userPosts)
            ],
          ),
        ),
        bottomNavigationBar: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            backgroundColor: Theme.of(context).backgroundColor,
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
                horizontal: 25 * MediaQuery.of(context).size.height / 1000,
                vertical: 25 *
                    MediaQuery.of(context).size.height /
                    1300), // navigation bar padding
            tabs: [
              GButton(
                icon: LineIcons.home,
              ),
              GButton(
                icon: LineIcons.hashtag,
              ),
              GButton(
                icon: LineIcons.pen,
              ),
              GButton(
                icon: LineIcons.layerGroup,
              ),
              GButton(
                icon: LineIcons.user,
              ),
            ]));
  }
}
