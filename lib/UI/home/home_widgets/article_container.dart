import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class ArticleContainer extends StatelessWidget {
  final String imageId;
  final String name;
  final DateTime date;
  final int likes;
  final String header;
  final String content;
  final String topic;

  const ArticleContainer({
    Key? key,
    required this.imageId,
    required this.name,
    required this.date,
    required this.likes,
    required this.header,
    required this.content,
    required this.topic,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 1 / 5.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: 'image1',
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Image.asset(
                  imageId,
                  fit: BoxFit.fill,
                  width: width * 1 / 4.5,
                  height: height * 1 / 4,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(18.0 * height / 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(header,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 15 * height / 800,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w100)),
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14 * height / 700),
                ),
                SizedBox(
                  height: height * 1 / 180,
                ),
                Container(
                  width: width * 1 / 3,
                  child: Text(
                    topic,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13 * height / 900),
                  ),
                ),
                SizedBox(
                  height: height * 1 / 250,
                ),
                Flexible(
                  child: Container(
                    child: Row(
                      children: [
                        LineIcon.thumbsUp(
                          color: Theme.of(context).cardColor,
                        ),
                        Text(
                          likes.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 13 * height / 700),
                        ),
                        SizedBox(
                          width: width * 1 / 120,
                        ),
                        LineIcon.clock(
                          color: Theme.of(context).cardColor,
                        ),
                        Text(
                          date.format(' M j, H:i'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 12 * height / 800),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
