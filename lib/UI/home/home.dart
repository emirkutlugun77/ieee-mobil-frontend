import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/article/articles.dart';

import 'package:my_app/UI/event/event_page.dart';
import 'package:my_app/UI/feed/social_feed.dart' as feed;

import 'package:my_app/UI/home/home_sections/home1.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/UI/models/announcement.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/profile/profile.dart' as profile;

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:socket_io_client/socket_io_client.dart';

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
  List<Post> userPosts = [];
  IO.Socket? socket;
  Post? postForDelete;
  void connectAndListen() {
    socket = IO.io(
        'https://ancient-falls-28306.herokuapp.com/',
        OptionBuilder().setTransports(['websocket']).setExtraHeaders({
          HttpHeaders.authorizationHeader: 'Bearer ${widget.token}'
        }).build());
    socket!.on('post-created', (data) {
      Post newPost = Post(
        date: DateTime.now(),
        id: data['_id'].toString(),
        likeCount: 0,
        liked: false,
        photo: data["photo"] != null ? data['photo'] : '',
        text: data['text'],
        userId: UserModelForPost.fromJson(data['userId']),
        v: 0,
      );
      setState(() {
        feed.posts.insert(0, newPost);
        print('inserted');
      });
    });
    socket!.onConnect((_) {
      print('connect');
    });
    socket!.on(
        'post-deleted',
        (data) => {
              print('post silindi'),
              feed.posts.forEach((element) {
                if (element.id == data['_id']) {
                  setState(() {
                    postForDelete = element;
                  });
                }
              }),
              setState(() {
                feed.posts.remove(postForDelete);
              })
            });
    socket!.onDisconnect((_) => print('disconnect'));
  }

  int _currentIndex = 0;
  PageController _pageController = PageController();

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      feed.posts = widget.posts.reversed.toList();
    });

    profile.user = widget.user;
    connectAndListen();
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
              feed.SocialFeed(
                user: widget.user,
                socket: socket!,
                posts: userPosts.reversed.toList(),
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
              profile.ProfilePage(
                  token: widget.token,
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
            iconSize: 26, // tab button icon size
            // selected tab background color
            padding: EdgeInsets.symmetric(
                horizontal: 20 * MediaQuery.of(context).size.height / 1000,
                vertical: 30 *
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
