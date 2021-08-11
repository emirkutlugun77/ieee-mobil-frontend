import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/UI/article/article_widgets/chip.dart';
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

class ProfilePage extends StatefulWidget {
  User user;
  List<MinEvent> minEvents;
  List<MinCertificate> minnCerts;
  List<MinCommittee> minCommittees;
  List<Post> userPosts;
  ProfilePage({
    Key? key,
    required this.user,
    required this.minEvents,
    required this.minnCerts,
    required this.minCommittees,
    required this.userPosts,
  }) : super(key: key);
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
                                          builder: (context) =>
                                              QrCode(user: widget.user)));
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
            ProfileContainer(
              width: width,
              height: height,
              user: widget.user,
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
                                  itemBuilder: (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Container(
                                        width: width,
                                        height: height * 1 / 6.5,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Hero(
                                              tag: widget.minEvents[index].id,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20)),
                                                  child: Image.network(
                                                    widget.minEvents[index]
                                                                .photo !=
                                                            ''
                                                        ? widget
                                                            .minEvents[index]
                                                            .photo
                                                        : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                                                    fit: BoxFit.fill,
                                                    width: width * 1 / 4.5,
                                                    height: height * 1 / 4,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  18.0 * height / 1200),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: width * 1 / 3.2,
                                                      child: Text(
                                                          widget
                                                              .minEvents[index]
                                                              .name,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline1!
                                                              .copyWith(
                                                                  fontSize: 14 *
                                                                      height /
                                                                      700,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 1 / 100,
                                                  ),
                                                  Text(
                                                    widget.minEvents[index]
                                                        .committeeName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(
                                                            fontSize: 13 *
                                                                height /
                                                                700),
                                                  ),
                                                  SizedBox(
                                                    height: height * 1 / 100,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ))))
                          : Center(
                              child: Text(
                                'Katıldığınız Etkinlik Yok',
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            )),
                  ProfileSection(
                      height: height,
                      width: width,
                      title: 'Komite Üyeliklerim',
                      child: Flexible(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.minCommittees.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    width: width,
                                    height: height * 1 / 6.5,
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: widget.minEvents[index].id,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20)),
                                              child: Image.network(
                                                widget.minCommittees[index]
                                                            .photo !=
                                                        ''
                                                    ? widget
                                                        .minCommittees[index]
                                                        .photo
                                                    : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                                                fit: BoxFit.fill,
                                                width: width * 1 / 4.5,
                                                height: height * 1 / 4,
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              8.0 * height / 1000),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: width * 1 / 3.2,
                                                    child: Text(
                                                        widget
                                                            .minCommittees[
                                                                index]
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1!
                                                            .copyWith(
                                                                fontSize: 14 *
                                                                    height /
                                                                    700,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: height / 30,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.instagram,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      width: width * 1 / 3,
                                                      child: Text(
                                                          widget
                                                              .minCommittees[
                                                                  index]
                                                              .instaUrl,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize: 9 *
                                                                      height /
                                                                      700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ))))),
                  ProfileSection(
                      height: height,
                      width: width,
                      title: 'Kazandığım Sertifikalar',
                      child: widget.minnCerts.length != 0
                          ? Flexible(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: widget.minnCerts.length,
                                  itemBuilder: (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Container(
                                        width: width,
                                        height: height * 1 / 4.5,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Hero(
                                              tag: widget.minEvents[index].id,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Stack(
                                                    children: [
                                                      Image.network(
                                                        widget.minnCerts[index]
                                                                    .photo !=
                                                                ''
                                                            ? widget
                                                                .minnCerts[
                                                                    index]
                                                                .photo
                                                            : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                                                        fit: BoxFit.fill,
                                                        width: width * 1 / 1.5,
                                                        height: height * 1 / 3,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ))))
                          : Padding(
                              padding: EdgeInsets.all(48.0 * height / 1000),
                              child: Center(
                                child: Text(
                                  'Henüz Sertifika Yok',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 20 * height / 600),
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
                                  itemCount: widget.userPosts.length,
                                  itemBuilder: (context, index) {
                                    return GFListTile(
                                        avatar: GFAvatar(
                                          backgroundImage: NetworkImage(widget
                                                      .userPosts[index]
                                                      .userId
                                                      .photo !=
                                                  ''
                                              ? widget
                                                  .userPosts[index].userId.photo
                                              : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                                          shape: GFAvatarShape.standard,
                                        ),
                                        title: Text(
                                          widget.userPosts[index].userId.name +
                                              ' ' +
                                              widget.userPosts[index].userId
                                                  .surname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                        description: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              widget.userPosts[index].date
                                                  .format('M j, H:i'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      fontSize:
                                                          12 * height / 800),
                                            ),
                                          ],
                                        ),
                                        subTitle: Text(
                                          widget.userPosts[index].text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        icon: LikeButton(
                                          likeCount:
                                              widget.userPosts[index].likeCount,
                                          isLiked:
                                              widget.userPosts[index].liked,
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.red,
                                            dotSecondaryColor: Colors.redAccent,
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              FontAwesomeIcons.solidHeart,
                                              color: isLiked
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 30,
                                            );
                                          },
                                        ));
                                  }),
                            )
                          : Padding(
                              padding: EdgeInsets.all(48.0 * height / 1000),
                              child: Center(
                                child: Text(
                                  'Henüz Blog Yazılmamış',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 20 * height / 600),
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
