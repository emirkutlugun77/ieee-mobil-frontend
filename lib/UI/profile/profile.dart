import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:image_picker/image_picker.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:my_app/Functions/auth_functions.dart';
import 'package:my_app/Functions/image_picker.dart';
import 'package:my_app/Functions/user.dart';
import 'package:my_app/UI/profile/new_register.dart';
import 'package:my_app/UI/widgets/marquee.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';
import 'package:my_app/UI/home/QR/qr.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/onboard/onboard.dart';
import 'package:my_app/UI/profile/profile_widgets/profile_container.dart';
import 'package:my_app/UI/profile/profile_widgets/profile_section.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:theme_provider/theme_provider.dart';

XFile? imageFile;

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  User user;
  final List<MinEvent> minEvents;
  final List<MinCertificate> minnCerts;
  final List<MinCommittee> minCommittees;
  final List<Post> userPosts;
  final String token;
  ProfilePage({
    Key? key,
    required this.token,
    required this.user,
    required this.minEvents,
    required this.minnCerts,
    required this.minCommittees,
    required this.userPosts,
  }) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

bool loadingCom = false;
bool loadingEvent = false;
User? user;

class _ProfilePageState extends State<ProfilePage> {
  PanelController _panelController = PanelController();
  PageController _pageController = PageController(initialPage: 0);
  int checkNum = 0;
  PanelController _panelController1 = PanelController();
  late Future getBlocked;
  @override
  void initState() {
    super.initState();
    getBlocked = getBlockedUsers(widget.user.blockedUsers);
  }

  List<User> blockedUsersProfile = [];

  Future getBlockedUsers(List<dynamic> blockedUsers) async {
    blockedUsers.forEach((element) async {
      User user = await getUser(element);

      setState(() {
        blockedUsersProfile.add(user);
      });
    });
  }

  int containerInt = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.transparent
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            color: Color(0xFFE6EAF1).withOpacity(0.1),
            child: Padding(
              padding: EdgeInsets.only(top: 58.0 * height / 900),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 58.0 * height / 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profil',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        widget.user.role == 0 || widget.user.role == 1
                            ? IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewRegister()));
                                },
                                icon: Icon(FontAwesomeIcons.userCheck,
                                    color: Theme.of(context).primaryColor))
                            : SizedBox(),
                        Container(
                          width: width / 2.5,
                          height: height / 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GFToggle(
                                  enabledTrackColor:
                                      Theme.of(context).primaryColorDark,
                                  enabledThumbColor:
                                      Theme.of(context).primaryColor,
                                  onChanged: (val) {
                                    ThemeProvider.controllerOf(context)
                                        .nextTheme();
                                  },
                                  value: ThemeProvider.themeOf(context).id ==
                                      'dark'),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QrCode(user: user!)));
                                  },
                                  child: Icon(FontAwesomeIcons.qrcode,
                                      color:
                                          Theme.of(context).iconTheme.color)),
                              GestureDetector(
                                onTap: () {
                                  _panelController1.open();
                                },
                                child: Icon(FontAwesomeIcons.userAltSlash,
                                    size: 25 * height / 1000,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    var value =
                                        await logoutDialog(context, height);
                                    if (value) {
                                      widget.userPosts.clear();
                                      widget.minnCerts.clear();
                                      widget.minCommittees.clear();
                                      widget.userPosts.clear();
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
                                  child: Icon(Icons.logout,
                                      color:
                                          Theme.of(context).iconTheme.color)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 1 / 40,
                  ),
                  ProfileContainer(
                    panelController: _panelController,
                    containerInt: containerInt,
                    pageController: _pageController,
                    width: width,
                    height: height,
                    user: user!,
                    committeCount: widget.minCommittees.length,
                    blogCount: widget.minnCerts.length,
                    eventCount: widget.minEvents.length,
                  ),
                  SizedBox(
                    height: height * 1 / 40,
                  ),
                  Flexible(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (pageNum) {
                        setState(() {
                          checkNum = pageNum;
                          containerInt = pageNum;
                        });
                      },
                      children: [
                        ProfileSection(
                            height: height,
                            width: width,
                            title: 'Katıldığım Etkinlikler',
                            child: widget.minEvents.length != 0
                                ? Flexible(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: widget.minEvents.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                child: Container(
                                                  width: width,
                                                  height: height * 1 / 6.5,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .backgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Hero(
                                                        tag: widget
                                                            .minEvents[index]
                                                            .id,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            child:
                                                                Image.network(
                                                              widget
                                                                          .minEvents[
                                                                              index]
                                                                          .photo !=
                                                                      ''
                                                                  ? widget
                                                                      .minEvents[
                                                                          index]
                                                                      .photo
                                                                  : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                                                              fit: BoxFit.cover,
                                                              width: width *
                                                                  1 /
                                                                  4.5,
                                                              height: height *
                                                                  1 /
                                                                  4,
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            18.0 *
                                                                height /
                                                                1200),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                width: width *
                                                                    1 /
                                                                    3.2,
                                                                child:
                                                                    MarqueeWidget(
                                                                  direction: Axis
                                                                      .vertical,
                                                                  child: Text(
                                                                      widget
                                                                          .minEvents[
                                                                              index]
                                                                          .name,
                                                                      style: Theme.of(context).textTheme.headline1!.copyWith(
                                                                          fontSize: 14 *
                                                                              height /
                                                                              700,
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w100)),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: height *
                                                                  1 /
                                                                  100,
                                                            ),
                                                            Container(
                                                              width:
                                                                  width / 2.5,
                                                              child: Text(
                                                                widget
                                                                    .minEvents[
                                                                        index]
                                                                    .committeeName,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle1!
                                                                    .copyWith(
                                                                        fontSize: widget.minEvents[index].committeeName.length >
                                                                                20
                                                                            ? 11 *
                                                                                height /
                                                                                700
                                                                            : 13 *
                                                                                height /
                                                                                700),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: height *
                                                                  1 /
                                                                  100,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))))
                                : Padding(
                                    padding:
                                        EdgeInsets.all(48.0 * height / 1000),
                                    child: Center(
                                      child: Text(
                                        'Henüz Etkinlik Yok',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontSize: 20 * height / 600),
                                      ),
                                    ),
                                  )),
                        ProfileSection(
                            height: height,
                            width: width,
                            title: 'Komite Üyeliklerim',
                            child: widget.minCommittees.length > 0
                                ? Flexible(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: widget.minCommittees.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                child: Container(
                                                  width: width,
                                                  height: height * 1 / 6.5,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .backgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                          child: Image.network(
                                                            widget
                                                                        .minCommittees[
                                                                            index]
                                                                        .photo !=
                                                                    ''
                                                                ? widget
                                                                    .minCommittees[
                                                                        index]
                                                                    .photo
                                                                : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                                                            fit: BoxFit.fill,
                                                            width:
                                                                width * 1 / 4.5,
                                                            height:
                                                                height * 1 / 4,
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0 *
                                                                height /
                                                                1000),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: width *
                                                                      1 /
                                                                      3.2,
                                                                  child: Text(
                                                                      widget
                                                                          .minCommittees[
                                                                              index]
                                                                          .name,
                                                                      style: Theme.of(context).textTheme.headline1!.copyWith(
                                                                          fontSize: 14 *
                                                                              height /
                                                                              700,
                                                                          color: Theme.of(context)
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w100)),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 30,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .instagram,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        width *
                                                                            1 /
                                                                            3,
                                                                    child: Text(
                                                                        widget
                                                                            .minCommittees[
                                                                                index]
                                                                            .instaUrl,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                                fontSize: 9 * height / 700,
                                                                                fontWeight: FontWeight.w100)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))))
                                : Padding(
                                    padding:
                                        EdgeInsets.all(48.0 * height / 1000),
                                    child: Center(
                                      child: Text(
                                        'Henüz Komite Yok',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontSize: 20 * height / 600),
                                      ),
                                    ),
                                  )),
                        ProfileSection(
                            height: height,
                            width: width,
                            title: 'Kazandığım Sertifikalar',
                            child: widget.minnCerts.length != 0
                                ? Flexible(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: widget.minnCerts.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                child: Container(
                                                  width: width,
                                                  height: height * 1 / 4.5,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .backgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Stack(
                                                            children: [
                                                              Image.network(
                                                                widget.minnCerts[index].photo !=
                                                                        ''
                                                                    ? widget
                                                                        .minnCerts[
                                                                            index]
                                                                        .photo
                                                                    : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                                                                fit:
                                                                    BoxFit.fill,
                                                                width: width *
                                                                    1 /
                                                                    1.5,
                                                                height: height *
                                                                    1 /
                                                                    3,
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ))))
                                : Padding(
                                    padding:
                                        EdgeInsets.all(48.0 * height / 1000),
                                    child: Center(
                                      child: Text(
                                        'Henüz Sertifika Yok',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontSize: 20 * height / 600),
                                      ),
                                    ),
                                  )),
                        ProfileSection(
                            height: height,
                            width: width,
                            title: 'Pano Yazılarım',
                            child: widget.userPosts.length != 0
                                ? Flexible(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: widget.userPosts.length,
                                        itemBuilder: (context, index) {
                                          return GFListTile(
                                            avatar: GFAvatar(
                                              backgroundImage: NetworkImage(widget
                                                          .userPosts[index]
                                                          .userId
                                                          .photo !=
                                                      ''
                                                  ? widget.userPosts[index]
                                                      .userId.photo
                                                  : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                                              shape: GFAvatarShape.standard,
                                            ),
                                            description: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  widget.userPosts[index].date
                                                      .add(Duration(hours: 3))
                                                      .format('m/j/y , H:i'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                          fontSize: 12 *
                                                              height /
                                                              800),
                                                ),
                                              ],
                                            ),
                                            subTitle: Text(
                                              widget.userPosts[index].text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          );
                                        }),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.all(48.0 * height / 1000),
                                    child: Center(
                                      child: Text(
                                        'Henüz Blog Yazılmamış',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontSize: 20 * height / 600),
                                      ),
                                    ),
                                  ))
                      ],
                    ),
                  ),
                  bottomIndicator(width, height)
                ],
              ),
            ),
          ),
          slidingProfile(height, context),
          SlidingUpPanel(
            controller: _panelController1,
            minHeight: 0,
            maxHeight: height,
            panel: FutureBuilder(
                future: getBlocked,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    default:
                      return Container(
                        height: height,
                        color: Theme.of(context).backgroundColor,
                        width: width,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _panelController1.close();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(58.0 * height / 1000),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.chevronDown,
                                        color:
                                            Theme.of(context).iconTheme.color)
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Bloklanan Kullanıcılar',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 30 * height / 1000))
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: blockedUsersProfile.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.all(8.0 * height / 1000),
                                      child: GFListTile(
                                        avatar: GFAvatar(
                                          backgroundImage: NetworkImage(
                                              blockedUsersProfile[index]
                                                          .photoXs !=
                                                      ''
                                                  ? blockedUsersProfile[index]
                                                      .photoXs
                                                  : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                                        ),
                                        title: Text(
                                          blockedUsersProfile[index].name +
                                              ' ' +
                                              blockedUsersProfile[index]
                                                  .surname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                        icon: GestureDetector(
                                            onTap: () {
                                              unBlockUser(
                                                  widget.user.id,
                                                  blockedUsersProfile[index].id,
                                                  widget.token);

                                              setState(() {
                                                widget.user.blockedUsers.remove(
                                                    blockedUsersProfile[index]
                                                        .id);
                                                blockedUsersProfile.removeWhere(
                                                    (element) =>
                                                        element.id ==
                                                        blockedUsersProfile[
                                                                index]
                                                            .id);
                                              });
                                            },
                                            child: Icon(FontAwesomeIcons.minus,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color)),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                  }
                }),
          ),
        ],
      ),
    );
  }

  SlidingUpPanel slidingProfile(double height, BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: () {
        setState(() {
          imageFile = null;
        });
      },
      controller: _panelController,
      minHeight: 0,
      slideDirection: SlideDirection.UP,
      maxHeight: height / 8,
      panel: Scaffold(
        body: Container(
          height: height / 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageFile != null
                  ? Center(
                      child: Image.file(
                          File(
                            imageFile!.path,
                          ),
                          height: height / 4),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              getImageFromCamera().then((value) {
                                setState(() {
                                  imageFile = value;
                                });
                                File image = File(imageFile!.path);
                                _panelController.close();
                                EasyLoading.show(
                                    indicator: LoadingBouncingGrid.square(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ));
                                updateUserPhoto(user!.id, image, widget.token)
                                    .then((value) {
                                  getMe(widget.token).then((value) {
                                    setState(() {
                                      user = value;
                                    });
                                  }).then((value) => EasyLoading.dismiss());
                                });
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.camera,
                              color: Theme.of(context).primaryColor,
                              size: 60 * height / 1000,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              getImageFromGallery().then((value) {
                                setState(() {
                                  imageFile = value;
                                });
                                File image = File(imageFile!.path);
                                _panelController.close();
                                EasyLoading.show(
                                    indicator: LoadingBouncingGrid.square(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ));
                                updateUserPhoto(user!.id, image, widget.token)
                                    .then((value) =>
                                        getMe(widget.token).then((value) {
                                          setState(() {
                                            user = value;
                                          });
                                        }))
                                    .then((value) => EasyLoading.dismiss());
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.image,
                              color: Theme.of(context).primaryColor,
                              size: 60 * height / 1000,
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> logoutDialog(BuildContext context, double height) {
    return showDialog(
        context: context,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
                content: Text('Çıkış Yapıyorsunuz'),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.0 * height / 1000),
                        child: Center(
                            child: Text('Devam Et',
                                style: Theme.of(context).textTheme.bodyText1)),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.0 * height / 1000),
                        child: Center(
                            child: Text('Geri Dön',
                                style: Theme.of(context).textTheme.bodyText1)),
                      ))
                ]);
          } else {
            return AlertDialog(title: Text('Çıkış Yapıyorsunuz'), actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0 * height / 1000),
                    child: Center(
                        child: Text('Devam Et',
                            style: Theme.of(context).textTheme.bodyText1!)),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0 * height / 1000),
                    child: Center(
                        child: Text('Geri Dön',
                            style: Theme.of(context).textTheme.bodyText1)),
                  ))
            ]);
          }
        });
  }

  Container bottomIndicator(double width, double height) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 1 / 3),
        child: Container(
          color: Theme.of(context).backgroundColor,
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
