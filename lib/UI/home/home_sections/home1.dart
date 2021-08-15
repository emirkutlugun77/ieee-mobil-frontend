import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';

import 'package:my_app/Functions/committee.dart';
import 'package:my_app/UI/article/article_page.dart';
import 'package:my_app/UI/article/articles.dart';
import 'package:my_app/UI/commitee_page/commitee.dart';

import 'package:my_app/UI/home/home_widgets/article_container.dart';
import 'package:my_app/UI/models/announcement.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class Home1 extends StatefulWidget {
  Home1(
      {required this.seenAnnouncements,
      required this.announcements,
      required this.user,
      required this.committees,
      required this.blogPosts});
  int seenAnnouncements;
  User user;
  List<Commitee> committees;
  List<BlogPost> blogPosts;
  List<Announcement> announcements;
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int current = 0;

  PanelController _panelController = PanelController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: width * 1 / 10.0,
                    right: width * 1 / 7.0,
                    left: width * 1 / 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hoşgeldin ${widget.user.name}!',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 20 * width / 400),
                    ),
                    GFIconBadge(
                      child: GFIconButton(
                        onPressed: () {
                          SharedPreferences.getInstance().then((value) {
                            value.setInt('seen', widget.announcements.length);
                          });
                          if (_panelController.isPanelClosed) {
                            _panelController.open();
                          } else {
                            _panelController.close();
                          }
                        },
                        icon: LineIcon.bell(
                          color: Theme.of(context).cardColor,
                          size: 30,
                        ),
                        type: GFButtonType.transparent,
                      ),
                      counterChild: GFBadge(
                        child: Text((widget.announcements.length -
                                widget.seenAnnouncements)
                            .toString()),
                        shape: GFBadgeShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 1 / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 58),
                child: Row(
                  children: [
                    Text(
                      'Komiteler',
                      style: Theme.of(context).textTheme.headline1,
                    )
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.committees.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: width * 1 / 50,
                          childAspectRatio: 2.8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ComiteePage(
                                          user: widget.user,
                                          commitee: widget.committees[index],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height * 1 / 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Hero(
                                      tag: widget.committees[index].photo,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            widget.committees[index].photo,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width * 1 / 4.3,
                                      child: Text(widget.committees[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: height * 1 / 60,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 58.0 * height / 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'En Popüler Yazılar',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Articles(
                                        blogPosts: widget.blogPosts,
                                      )));
                        },
                        child: Text(
                          'Daha Fazla',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14 * height / 700),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: height * 1 / 60,
              ),
              Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.blogPosts.length >= 5 != true
                        ? widget.blogPosts.length
                        : 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticlePage(
                                              blogPost: widget.blogPosts[index],
                                            )));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 10),
                                child: ArticleContainer(
                                  width: width,
                                  height: height,
                                  blogPost: widget.blogPosts[index],
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
        SlidingUpPanel(
          renderPanelSheet: false,
          padding: EdgeInsets.symmetric(
              vertical: 60.0 * height / 1500, horizontal: 60.0 * height / 1000),
          backdropEnabled: false,
          color: Colors.transparent,
          slideDirection: SlideDirection.DOWN,
          maxHeight: height / 1.5,
          minHeight: 0,
          controller: _panelController,
          panel: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: width,
                  height: height / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.accents[0])),
                  child: Padding(
                    padding: EdgeInsets.all(28.0 * height / 1000),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Text(
                                'Bildirimler',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            child: ListView.builder(
                                itemCount: widget.announcements.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 4),
                                      child: Container(
                                          width: width,
                                          height: widget.announcements[index]
                                                      .text.length >=
                                                  30
                                              ? height / 4.5
                                              : height / 8,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      widget
                                                          .announcements[index]
                                                          .committeeName,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200)),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        8.0 * height / 1000),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        widget
                                                            .announcements[
                                                                index]
                                                            .text,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    widget.announcements[index]
                                                        .date
                                                        .format(
                                                      'M j, H:i',
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        4.0 * height / 1000),
                                                child: Divider(),
                                              )
                                            ],
                                          )));
                                }))
                      ],
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
