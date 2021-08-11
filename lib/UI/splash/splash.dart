import 'dart:async';

import 'package:flutter/material.dart';

import 'package:my_app/Functions/auth_functions.dart';
import 'package:my_app/Functions/blog.dart';
import 'package:my_app/Functions/committee.dart';
import 'package:my_app/Functions/events.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/Functions/user.dart';
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/home/home.dart';
import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

User? user;

List<MinEvent> minEvents = [];
List<MinCertificate> minnCerts = [];
List<MinCommittee> minCommittees = [];
List<Commitee> commiteeList = [];
List<Post> userPosts = [];
List<BlogPost> blogPosts = [];
List<Event> events = [];
bool logging = true;
List<Post> posts = [];
String token = '';
String? id;
Future futureOperation(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  id = prefs.getString('id');
  token = prefs.getString('token')!;
  user = await getUser(id!);

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
    Future.wait([
      getMost5(blogPosts),
      getAllCommittees(commiteeList),
      getAllEvents(0).then((value) => events = value),
      getAllPosts(posts),
      futureOperation(context)
    ])
        .then((value) => Future.delayed(Duration(milliseconds: 1500)))
        .then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
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
                    ))));
  }

  double opacityValue = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: 350),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 200.0, bottom: 18, left: 40, right: 40),
              child: Image.asset(
                'images/social.png',
                height: MediaQuery.of(context).size.height / 4,
                fit: BoxFit.fill,
                scale: 1.5,
              ),
            ),
          ),
          Image.asset(
            'images/splash.png',
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width / 1.2,
            scale: 0.1,
          ),
        ],
      ),
    );
  }
}
// ignore: non_constant_identifier_names
