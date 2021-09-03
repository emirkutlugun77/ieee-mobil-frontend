import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Functions/notifications.dart';

import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/article/articles.dart';
import 'package:my_app/UI/auth/auth_widgets/slidingUpPanel.dart';

import 'package:my_app/UI/event/event_page.dart';
import 'package:my_app/UI/feed/social_feed.dart' as feed;

import 'package:my_app/UI/home/home_sections/home1.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/UI/models/announcement.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/notification.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/profile/profile.dart' as profile;
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
      required this.userPosts,
      required this.notifications});
  int seenAnnouncements;
  List<Announcement> announcements;
  User user;
  String token;
  List<Commitee> committees;
  List<BlogPost> blogPosts;
  List<NotificationModel> notifications;
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
  CarouselController _carouselController = CarouselController();
  PanelController _panelController = PanelController();
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

  bool showPanel = false;
  @override
  void initState() {
    super.initState();
    /* widget.notifications.forEach((element) {
      readNotifications(widget.user.id, element.id);
    });*/
    Future.delayed(Duration(milliseconds: 600)).then((value) {
      setState(() {
        showPanel = true;
      });
    });
    setState(() {
      feed.posts = widget.posts.reversed.toList();
      feed.posts = feed.posts
          .where((element) =>
              widget.user.blockedUsers.contains(element.userId.id) == false)
          .toList();
    });

    profile.user = widget.user;
    connectAndListen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
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
            buildSlidingForNotificationAtStart()
          ],
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

            color: Theme.of(context).bottomAppBarColor,
            activeColor: Theme.of(context).primaryColor,

            // selected icon and text color
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

  Widget buildSlidingForNotificationAtStart() {
    if (widget.notifications.length > 0) {
      return AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: showPanel ? 1 : 0,
        child: SlidingUpPanel(
            renderPanelSheet: false,
            controller: _panelController,
            maxHeight: MediaQuery.of(context).size.height,
            backdropTapClosesPanel: true,
            defaultPanelState: PanelState.OPEN,
            panel: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: widget.notifications.length,
                  itemBuilder: (context, index, pageIndex) {
                    return notificationWidget(widget.notifications[index]);
                  },
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 1.8,
                      enableInfiniteScroll: false,
                      aspectRatio: 0.1,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      8.0 * MediaQuery.of(context).size.height / 1000),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                _carouselController.previousPage();
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                _carouselController.nextPage();
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )),
      );
    }
    return SizedBox();
  }

  Center notificationWidget(NotificationModel notification) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.all(38.0 * MediaQuery.of(context).size.height / 1000),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.8,
          child: Stack(
            children: [
              Material(
                elevation: 10,
                shadowColor: Colors.grey.shade50,
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: CachedNetworkImage(
                            imageUrl: notification.coverImage),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            8.0 * MediaQuery.of(context).size.height / 1000),
                        child: Text(
                          notification.context,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 18 *
                                      MediaQuery.of(context).size.height /
                                      1000),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      buildActionButtonsForNotificationPanel(
                          notification.actionType)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildActionButtonsForNotificationPanel(String actionType) {
    switch (actionType) {
      case 'basic':
        return Flexible(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Theme.of(context).primaryColor),
            child: Center(
              child: TextButton(
                onPressed: () {
                  _panelController.close();
                },
                child: Text(
                  'Tamam',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );

      default:
    }
  }
}
