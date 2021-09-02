import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:my_app/Functions/committee.dart';
import 'package:my_app/Functions/events.dart';

import 'package:my_app/Functions/search.dart';

import 'package:my_app/UI/commitee_page/commitee.dart';
import 'package:my_app/UI/event/single_event.dart';

import 'package:my_app/UI/models/announcement.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/widgets/marquee.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum searchState { FOUND, LOOKING, NO_RESULTS, INIT }
ListBox result = ListBox(events: [], committees: []);

// ignore: must_be_immutable
class Home1 extends StatefulWidget {
  Home1({
    required this.seenAnnouncements,
    required this.announcements,
    required this.user,
    required this.committees,
    required this.blogPosts,
  });
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
  PanelController _panelController1 = PanelController();
  searchState status = searchState.INIT;

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.transparent
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding:
                EdgeInsets.all(4.0 * MediaQuery.of(context).size.height / 700),
            child: buildFloatingSearchBar(context),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 7.5),
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 58 * height / 1000,
                        vertical: 19 * height / 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Komiteler',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0 * height / 1000),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.committees.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ComiteePage(
                                              user: widget.user,
                                              commitee:
                                                  widget.committees[index],
                                            )));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(6.0 * height / 1000),
                                child: Container(
                                  height: height * 1 / 13,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).backgroundColor),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Hero(
                                          tag: widget.committees[index].photo,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              imageUrl: widget
                                                  .committees[index].photo,
                                              width: width / 10,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRO2A88sIt_waHvZPhZQnnyt06SfGKFhqxVBg&usqp=CAU'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width * 1 / 4,
                                        child: MarqueeWidget(
                                          direction: Axis.vertical,
                                          child: Text(
                                              widget.committees[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                      ),
                                      Container(
                                        width: width / 5,
                                        child: Stack(
                                          children: [
                                            avatarMethod(35 * height / 1000,
                                                index.isEven ? 6 : 2),
                                            avatarMethod(20 * height / 1000,
                                                index.isEven ? 3 : 1),
                                            avatarMethod(5 * height / 1000,
                                                index.isEven ? 5 : 4),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 5,
                                        child: Text(
                                            widget.committees[index]
                                                    .subscriptionCount
                                                    .toString() +
                                                ' Üye',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          announcePanel(height, width, context),
          SlidingUpPanel(
              defaultPanelState: PanelState.CLOSED,
              onPanelClosed: () {
                setState(() {
                  status = searchState.INIT;
                });
              },
              maxHeight: height,
              renderPanelSheet: false,
              padding: EdgeInsets.only(
                top: 60.0 * height / 1500,
              ),
              backdropEnabled: false,
              color: Colors.transparent,
              slideDirection: SlideDirection.DOWN,
              minHeight: 0,
              controller: _panelController1,
              panel: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: height,
                    width: width,
                    color: Theme.of(context).backgroundColor,
                    child: Padding(
                      padding: EdgeInsets.only(top: 59.0),
                      child: Column(
                        children: [
                          result.committees.length > 0
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: 38.0 * height / 1000,
                                      left: 38.0 * height / 1000),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            _panelController1.close();
                                          },
                                          child: Icon(
                                              FontAwesomeIcons.chevronUp,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0, vertical: 8),
                                        child: Text(
                                          result.committees.length > 0
                                              ? 'Komiteler'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          Builder(builder: (context) {
                            if (result.committees.length > 0) {
                              return Flexible(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: result.committees.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          EasyLoading.show(
                                              indicator:
                                                  LoadingBouncingGrid.square(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ));
                                          Commitee com = await getCommitteeById(
                                              result.committees[index].id);
                                          EasyLoading.dismiss();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComiteePage(
                                                        commitee: com,
                                                        user: widget.user,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 28),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: GFListTile(
                                                avatar: CachedNetworkImage(
                                                  imageUrl: result
                                                      .committees[index].photo,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                                title: Text(
                                                    result
                                                        .committees[index].name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            color:
                                                                Colors.black)),
                                                icon: Icon(FontAwesomeIcons
                                                    .chevronRight)),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                          result.events.length > 0
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: 38.0 * height / 1000,
                                      left: 38.0 * height / 1000),
                                  child: Row(
                                    children: [
                                      result.committees.length > 0
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                _panelController1.close();
                                              },
                                              child: Icon(
                                                  FontAwesomeIcons.chevronUp,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0, vertical: 8),
                                        child: Text(
                                          result.events.length > 0
                                              ? 'Etkinlikler'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          Builder(builder: (context) {
                            if (result.events.length > 0) {
                              return Flexible(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: result.events.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          EasyLoading.show(
                                              indicator:
                                                  LoadingBouncingGrid.square(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ));
                                          Event event = await getEventById(
                                              result.events[index].id);
                                          EasyLoading.dismiss();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SingleEvent(
                                                        event: event,
                                                        user: widget.user,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 28),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: GFListTile(
                                                avatar: CachedNetworkImage(
                                                  imageUrl: result
                                                      .events[index].photo,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                                title: Text(
                                                    result.events[index].name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            color:
                                                                Colors.black)),
                                                icon: Icon(
                                                    FontAwesomeIcons
                                                        .chevronRight,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color)),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  SlidingUpPanel announcePanel(
      double height, double width, BuildContext context) {
    return SlidingUpPanel(
      maxHeight: status == searchState.FOUND ? height : height / 1.5,
      renderPanelSheet: false,
      onPanelOpened: () {
        setState(() {
          widget.seenAnnouncements = widget.announcements.length;
        });
      },
      padding: EdgeInsets.symmetric(
          vertical: 60.0 * height / 1500, horizontal: 60.0 * height / 1000),
      backdropEnabled: false,
      color: Colors.transparent,
      slideDirection: SlideDirection.DOWN,
      minHeight: 0,
      controller: _panelController,
      panel: Container(
        height: height / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: width,
                height: height / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).backgroundColor,
                    border: Border.all(color: Theme.of(context).primaryColor)),
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
                                        vertical: 8 * height / 1000,
                                        horizontal: 4 * height / 1000),
                                    child: Container(
                                        width: width,
                                        height: widget.announcements[index].text
                                                    .length >=
                                                30
                                            ? height / 4.5
                                            : height / 8,
                                        color:
                                            Theme.of(context).backgroundColor,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: width / 1.7,
                                                  child: Text(
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
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      8.0 * height / 1000),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      width: width / 1.5,
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  widget
                                                      .announcements[index].date
                                                      .add(Duration(hours: 3))
                                                      .format('m/j/y , H:i'),
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
                                          ],
                                        )));
                              }))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      onSubmitted: (query) {
        setState(() {
          status = searchState.LOOKING;
          if (query == '') {
            status = searchState.INIT;
          } else {
            searchAll(query).then((value) => setState(() {
                  result = value;
                  if (result.committees.length > 0 ||
                      result.events.length > 0) {
                    status = searchState.FOUND;
                    _panelController1.open();
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          if (Platform.isIOS) {
                            return CupertinoAlertDialog(
                              title: Text('Sonuç Yok'),
                            );
                          } else {
                            return AlertDialog(
                              title: Text('Sonuç Yok'),
                            );
                          }
                        });
                    status = searchState.INIT;
                  }
                }));
          }
        });
      },
      actions: [
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
              color: Theme.of(context).iconTheme.color,
              size: 30,
            ),
            type: GFButtonType.transparent,
          ),
          counterChild: GFBadge(
            child: Text((widget.announcements.length - widget.seenAnnouncements)
                .toString()),
            shape: GFBadgeShape.circle,
            color: Theme.of(context).errorColor,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColorLight,
      automaticallyImplyBackButton: false,
      backdropColor: Colors.transparent,
      hint: 'Ara',
      hintStyle: Theme.of(context).textTheme.bodyText1,
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      builder: (context, transition) {
        return SizedBox();
      },
    );
  }

  Padding avatarMethod(double left, int image) {
    return Padding(
      padding: EdgeInsets.only(left: left),
      child: Container(
        height: MediaQuery.of(context).size.height / 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: Theme.of(context).backgroundColor,
            width: 1.0,
          ),
        ),
        child: CircleAvatar(
            backgroundColor: Colors.accents[image + 4],
            backgroundImage: AssetImage('images/avatar$image.png')),
      ),
    );
  }
}
