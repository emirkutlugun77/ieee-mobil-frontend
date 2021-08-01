import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:my_app/UI/models/event.dart';

class SingleEvent extends StatefulWidget {
  final Event event;

  const SingleEvent({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _SingleEventState createState() => _SingleEventState();
}

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
                      child: GFAccordion(
                        contentBorderRadius: BorderRadius.circular(10),
                        showAccordion: false,
                        contentChild: Container(
                            height: height * 1 / 3.3,
                            width: double.infinity,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (context, index) => GFListTile(
                                  title: Text(
                                    'Oturum $index',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 20),
                                  ),
                                  subTitle: Text(
                                    'ed ut perspiciatis unde omnis iste natus error',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  icon: LineIcon.video(
                                    color: Theme.of(context).primaryColor,
                                  )),
                            )),
                        contentBackgroundColor:
                            Color(0xFFE6EAF1).withOpacity(0.1),
                        expandedTitleBackgroundColor:
                            Color(0xFFE6EAF1).withOpacity(0.1),
                        collapsedTitleBackgroundColor:
                            Color(0xFFE6EAF1).withOpacity(0.1),
                        title: 'Oturumlar',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18 * height / 700),
                        collapsedIcon: LineIcon.angleDown(),
                        expandedIcon: LineIcon.angleUp(),
                      ),
                    ),
                    SizedBox(
                      height: height * 1 / 100,
                    ),
                    Material(
                      child: GFAccordion(
                        showAccordion: false,
                        contentChild: Container(
                            height: height * 1 / 3.3,
                            width: double.infinity,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: widget.event.commentCount,
                              itemBuilder: (context, index) => GFListTile(
                                  description: Text(
                                    widget.event.eventDate
                                        .format('M j, H:i')
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  title: Text(
                                    'Yorum $index',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 20),
                                  ),
                                  subTitle: Text(
                                    'ed ut perspiciatis unde omnis iste natus error',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  icon: LineIcon.thumbsUp(
                                    color: Theme.of(context).primaryColor,
                                  )),
                            )),
                        contentBackgroundColor:
                            Color(0xFFE6EAF1).withOpacity(0.1),
                        expandedTitleBackgroundColor:
                            Color(0xFFE6EAF1).withOpacity(0.1),
                        collapsedTitleBackgroundColor:
                            Color(0xFFE6EAF1).withOpacity(0.1),
                        title: 'Yorumlar',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18 * height / 700),
                        collapsedIcon: LineIcon.angleDown(),
                        expandedIcon: LineIcon.angleUp(),
                      ),
                    ),
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
            )
          ],
        ),
      ),
    );
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
