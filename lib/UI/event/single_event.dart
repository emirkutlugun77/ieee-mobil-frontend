import 'dart:io';

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
  var alignToCenter = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: Duration(milliseconds: 360),
      color: alignToCenter ? Color(0xFFE6EAF1).withOpacity(0.8) : Colors.white,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: alignToCenter ? 0 : 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.0 * height / 1000),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 2 / 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 28.0 * height / 1000,
                          bottom: 15.0 * height / 1000),
                      child: Text(
                        widget.event.name,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: height * 1 / 100,
                    ),
                    Container(
                        height: height * 1 / 4,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Builder(builder: (context) {
                            if (widget.event.description.contains('<')) {
                              return Html(
                                data: widget.event.description,
                              );
                            } else {
                              return Text(widget.event.description,
                                  style: Theme.of(context).textTheme.bodyText1);
                            }
                          }),
                        )),
                    SizedBox(
                      height: height * 1 / 100,
                    ),
                    CustomDiv(),
                    SizedBox(
                      height: height * 1 / 100,
                    ),
                    Material(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width / 1.2,
                        height: height * 1 / 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Oturumlar',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  commentOrSession = false;
                                  _panelController.open();
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.chevronUp,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    SizedBox(
                      height: height * 1 / 100,
                    ),
                    Material(
                        child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Container(
                        width: width / 1.2,
                        height: height * 1 / 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Yorumlar',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                FontAwesomeIcons.chevronUp,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            _imageContainer(height, width),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 360),
                opacity: alignToCenter ? 0 : 1,
                child: Padding(
                  padding: EdgeInsets.all(38),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineIcon.angleLeft(
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              child: slidingForEvent(
                height,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SlidingUpPanel slidingForEvent(
    double height,
  ) {
    if (commentOrSession) {
      return SlidingUpPanel(
        boxShadow: [BoxShadow(blurRadius: 0, color: Colors.transparent)],
        color: Colors.transparent,
        controller: _panelController,
        defaultPanelState: PanelState.CLOSED,
        minHeight: 0,
        maxHeight: height,
        slideDirection: SlideDirection.UP,
        panel: Container(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Yorumlar'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flexible(
                      child: ListView.builder(itemBuilder: (context, index) {
                    return SizedBox();
                  })),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return SlidingUpPanel(
        controller: _panelController,
        defaultPanelState: PanelState.CLOSED,
        minHeight: 0,
        maxHeight: height,
        slideDirection: SlideDirection.DOWN,
        panel: Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _panelController.close();
                      },
                      child: Icon(FontAwesomeIcons.chevronLeft),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Oturumlar',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: height - 102,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: widget.event.sessions.length,
                      itemBuilder: (context, index) {
                        return GFListTile(
                          titleText: widget.event.sessions[index].title,
                          subTitleText: widget.event.sessions[index].time
                              .format('M j, H:i'),
                          icon: widget.event.sessions[index].attendanceButton
                              ? GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        widget.event.sessions[index].link,
                                        context);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(FontAwesomeIcons.chevronRight),
                                    ],
                                  ))
                              : Icon(Icons.clear),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  AnimatedContainer _imageContainer(double height, double width) {
    return AnimatedContainer(
      height: alignToCenter ? height * 5 / 5 : height * 2 / 5,
      width: width,
      duration: Duration(milliseconds: 365),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            alignToCenter = !alignToCenter;
          });
        },
        child: Hero(
          tag: widget.event.photo,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  width: width,
                  imageUrl: widget.event.photo,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDiv extends StatelessWidget {
  const CustomDiv({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: Colors.black,
    );
  }
}

void _launchURL(String _url, context) async => await canLaunch(_url)
    ? await launch(_url)
    : showDialog(
        context: context,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text('Link Hatalı'),
            );
          } else {
            return AlertDialog(
              title: Text('Link Hatalı'),
            );
          }
        });
