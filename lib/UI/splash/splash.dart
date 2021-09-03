import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/Functions/announce.dart';

import 'package:my_app/Functions/auth_functions.dart';
import 'package:my_app/Functions/blog.dart';
import 'package:my_app/Functions/committee.dart';
import 'package:my_app/Functions/events.dart';
import 'package:my_app/Functions/notifications.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/Functions/user.dart';
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/home/home.dart';
import 'package:my_app/UI/models/announcement.dart';
import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/notification.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

User? user;
List<NotificationModel> notifications = [];
List<MinEvent> minEvents = [];
List<MinCertificate> minnCerts = [];
List<MinCommittee> minCommittees = [];
List<Commitee> commiteeList = [];
List<Post> userPosts = [];
List<BlogPost> blogPosts = [];
List<Announcement> announcementList = [];
List<Event> events = [];
bool logging = true;
List<Post> posts = [];
String token = '';
String? id;
int? seenAnnouncements;
Future futureOperation(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  id = prefs.getString('id');
  token = prefs.getString('token')!;
  user = await getUser(id!);
  seenAnnouncements = prefs.getInt('seen') != null ? prefs.getInt('seen') : 0;
  await getUserData(id!, minCommittees, minnCerts, minEvents, userPosts, token);

  logging = false;
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (opacityValue == 1) {
        setState(() {
          opacityValue = 0;
        });
      } else {
        setState(() {
          opacityValue = 1;
        });
      }
    });
    futureOperation(context).then((value) => Future.wait([
          getMost5(blogPosts, token, 0),
          getAllCommittees(commiteeList),
          getAllEvents(0).then((value) => events = value),
          getAllPosts(posts),
          getAnnouncements(token).then((value) => announcementList = value),
          getNotifications(user!.id, token, notifications)
        ]).then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      notifications: notifications,
                      seenAnnouncements: seenAnnouncements!,
                      announcements: announcementList,
                      events: events,
                      user: user!,
                      committees: commiteeList,
                      blogPosts: blogPosts,
                      posts: posts,
                      token: token,
                      minCommittees: minCommittees,
                      minEvents: minEvents,
                      minnCerts: minnCerts,
                      userPosts: userPosts,
                    )))));
  }

  double opacityValue = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: 350),
            child: Padding(
              padding: EdgeInsets.all(
                  38.0 * MediaQuery.of(context).size.height / 1000),
              child: Center(
                child: Image.asset(
                  'images/social.png',
                  height: MediaQuery.of(context).size.height / 4,
                  fit: BoxFit.fill,
                  scale: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ignore: non_constant_identifier_names
