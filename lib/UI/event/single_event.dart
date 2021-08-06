import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleEvent extends StatefulWidget {
  final Event event;

  const SingleEvent({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _SingleEventState createState() => _SingleEventState();
}

bool commentOrSession = false;
PanelController _panelController = PanelController();

class _SingleEventState extends State<SingleEvent> {
  bool showUsers = false;
  List randomNumbers = [
    Random().nextInt(2) + 1, //1,2
    Random().nextInt(2) + 3, //3,4
    Random().nextInt(2) + 5 //5,6
  ];

  @override
  void initState() {
    // TODO: implement initState
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

    return Scaffold(
      floatingActionButton: Container(
        width: width / 2,
        height: height / 15,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(4.0 * height / 1000),
          child: FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.all(8.0 * height / 1000),
                        child: Text('Yorumlar',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Theme.of(context).backgroundColor)),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.0 * height / 1000),
                      child: VerticalDivider(
                          color: Theme.of(context).backgroundColor),
                    )),
                    GestureDetector(
                      onTap: () {
                        _panelController.open();
                      },
                      child: Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.all(8.0 * height / 1000),
                          child: Text('Oturumlar',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color:
                                          Theme.of(context).backgroundColor)),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
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
                              child: Text(widget.event.eventDate
                                  .format(r'g:i a · M j, Y')),
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
                              child: Icon(FontAwesomeIcons.pager,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 16.0),
                              child: Text(
                                widget.event.website != ''
                                    ? widget.event.website
                                    : 'https://social.ieeeytu.com/',
                                style: TextStyle(fontSize: 22 * height / 1000),
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
                      Flexible(
                          child: Container(
                              child: SingleChildScrollView(
                                  child:
                                      Html(data: widget.event.description)))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SlidingUpPanel(
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              height: width / 4,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 0.5)),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: width / 1.6,
                                      child: Text(
                                          widget.event.sessions[index].title)),
                                  Icon(FontAwesomeIcons.chevronRight)
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
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
                                                  fontSize: 17 * height / 700,
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
