import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:my_app/Functions/events.dart';
import 'package:my_app/UI/models/comment.dart';
import 'package:my_app/scan.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:my_app/UI/article/article_widgets/chip_for_event.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/user.dart';

class SingleEvent extends StatefulWidget {
  final Event event;
  final User user;
  const SingleEvent({
    Key? key,
    required this.event,
    required this.user,
  }) : super(key: key);

  @override
  _SingleEventState createState() => _SingleEventState();
}

const List<String> choices = <String>['QR Kod Oku'];
bool commentOrSession = false;
PanelController _panelController = PanelController();
PanelController _panelController1 = PanelController();
List<Comment> comments = [];

class _SingleEventState extends State<SingleEvent> {
  bool showUsers = false;
  List randomNumbers = [
    Random().nextInt(2) + 1, //1,2
    Random().nextInt(2) + 3, //3,4
    Random().nextInt(2) + 5 //5,6
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 450)).then((value) {
      setState(() {
        showUsers = true;
      });
    });
  }

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
      ..dismissOnTap = false;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: width,
                height: height / 3.4,
                child: Stack(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              if (Platform.isIOS) {
                                return CupertinoAlertDialog(
                                  content: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      widget.event.photo,
                                      height: height / 1.9,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              } else {
                                return AlertDialog(
                                  content: Image.network(
                                    widget.event.photo,
                                    height: height / 1.9,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }
                            });
                      },
                      child: Hero(
                        tag: widget.event.photo,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          width: width,
                          height: height / 4,
                          imageUrl: widget.event.photo,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(38.0 * height / 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              comments.clear();
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Theme.of(context).backgroundColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    eventBox(height, width, context),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 38.0 * height / 1000,
                      vertical: 18.0 * height / 1000),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width / 1.30,
                            child: Text(widget.event.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize: 35 * height / 700,
                                        fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: width / 10.0, bottom: width / 15.0),
                        child: Row(
                          children: [
                            Container(
                              width: width / 7,
                              height: width / 7,
                              decoration: BoxDecoration(
                                  color: Color(0xFFECEDFE),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Icon(FontAwesomeIcons.calendarAlt,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 16.0),
                              child: Text(
                                  widget.event.eventDate.format('m/j/y , H:i')),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: width / 7,
                            height: width / 7,
                            decoration: BoxDecoration(
                                color: Color(0xFFECEDFE),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Icon(FontAwesomeIcons.comment,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 16.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.all(8.0 * height / 1000),
                                    child: GestureDetector(
                                      onTap: () async {
                                        comments.clear();
                                        EasyLoading.show(
                                            indicator:
                                                LoadingBouncingGrid.square(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ));
                                        await findEventComments(
                                            comments, widget.event.id);
                                        setState(() {});
                                        EasyLoading.dismiss();
                                        _panelController1.open();
                                      },
                                      child: CustomChipForEvent(
                                        tag: 'Yorumlar',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(8.0 * height / 1000),
                                    child: GestureDetector(
                                      onTap: () {
                                        _panelController.open();
                                      },
                                      child: CustomChipForEvent(
                                        tag: 'Oturumlar',
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: width / 12.0 * height / 1000,
                        ),
                        child: Row(children: [
                          Text('Etkinlik Hakkında',
                              style: Theme.of(context).textTheme.headline1),
                        ]),
                      ),
                      Html(data: widget.event.description),
                    ],
                  ),
                ),
              ),
            ],
          ),
          slidingForSessions(height, context, width),
          slidingForComments(
            height,
            context,
            width,
          )
        ],
      ),
    );
  }

  SlidingUpPanel slidingForSessions(
      double height, BuildContext context, double width) {
    return SlidingUpPanel(
      slideDirection: SlideDirection.UP,
      minHeight: 0,
      maxHeight: height,
      defaultPanelState: PanelState.CLOSED,
      controller: _panelController,
      panel: Padding(
        padding: EdgeInsets.all(58.0 * height / 1000),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _panelController.close();
                      },
                      child: Icon(Icons.clear))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oturumlar',
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
              ListView.builder(
                  padding: EdgeInsets.all(3),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.event.sessions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0 * height / 1000),
                      child: Container(
                        width: width,
                        height: width / 4,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5)),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: width / 1.7,
                                    child: Text(
                                        widget.event.sessions[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ),
                                  Container(
                                      width: width / 2,
                                      child: Text(
                                        widget.event.sessions[index].time
                                            .format('m/j/y , H:i'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      )),
                                ],
                              ),
                            ),
                            widget.user.role == 0 ||
                                    widget.user.role == 1 ||
                                    widget.user.role == 4
                                ? PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Icon(FontAwesomeIcons.ellipsisH),
                                    itemBuilder: (BuildContext context) {
                                      return choices.map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: GestureDetector(
                                              onTap: () async {
                                                if (choice == 'QR Kod Oku') {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ScanViewPage(
                                                                eventId: widget
                                                                    .event.id,
                                                                sessionId: widget
                                                                    .event
                                                                    .sessions[
                                                                        index]
                                                                    .id,
                                                              )));
                                                }
                                              },
                                              child: Text(choice)),
                                        );
                                      }).toList();
                                    },
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  SlidingUpPanel slidingForComments(
    double height,
    BuildContext context,
    double width,
  ) {
    return SlidingUpPanel(
      slideDirection: SlideDirection.UP,
      minHeight: 0,
      maxHeight: height,
      defaultPanelState: PanelState.CLOSED,
      controller: _panelController1,
      panel: Padding(
        padding: EdgeInsets.all(38.0 * height / 1000),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _panelController1.close();
                      },
                      child: Icon(Icons.clear))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Yorumlar',
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
              comments.length == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 100.0 * height / 1000),
                        child: Text(
                          'Henüz Yorum Yok',
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(3),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return GFListTile(
                          avatar: GFAvatar(
                            backgroundImage: NetworkImage(comments[index]
                                        .userId
                                        .photo !=
                                    ''
                                ? comments[index].userId.photo
                                : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                            shape: GFAvatarShape.standard,
                          ),
                          title: Text(
                            comments[index].userId.name +
                                ' ' +
                                comments[index].userId.surname,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          description: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                comments[index].date.format('m/j/y , H:i'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 12 * height / 800),
                              ),
                            ],
                          ),
                          subTitle: Text(
                            comments[index].text,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }

  Align eventBox(double height, double width, BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: showUsers ? 1 : 0,
          child: Container(
            height: height * 0.08,
            width: width / 1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).backgroundColor,
                boxShadow: [BoxShadow(blurRadius: 40, color: Colors.grey)]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.event.appCount > 3
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 15),
                        child: Container(
                            width: width / 1.45,
                            height: height * 0.06,
                            child: Padding(
                              padding: EdgeInsets.all(8.0 * height / 1000),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      avatarMethod(54 * height / 1000, 2),
                                      avatarMethod(30 * height / 1000, 1),
                                      avatarMethod(8 * height / 1000, 0),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.all(5.0 * height / 1000),
                                      child: Text(
                                          widget.event.eventDate
                                                  .isAfter(DateTime.now())
                                              ? '+${widget.event.appCount - 3} Kişi Katılıyor'
                                              : '+${widget.event.appCount - 3} Kişi Katıldı',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  fontSize: 15 * height / 700,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold)))
                                ],
                              ),
                            )),
                      )
                    : Text('Katılım Bilgisi Yok',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 17 * height / 700,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ));
  }

  Padding avatarMethod(double left, int image) {
    return Padding(
      padding: EdgeInsets.only(left: left),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: Theme.of(context).backgroundColor,
            width: 1.0,
          ),
        ),
        child: CircleAvatar(
            backgroundColor: Colors.accents[image + 4],
            backgroundImage:
                AssetImage('images/avatar${randomNumbers[image]}.png')),
      ),
    );
  }
}
