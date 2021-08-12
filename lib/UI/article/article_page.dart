import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:line_icons/line_icon.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:my_app/UI/article/article_widgets/chip.dart';
import 'package:my_app/UI/models/blogposts.dart';

class ArticlePage extends StatefulWidget {
  final BlogPost blogPost;
  ArticlePage({required this.blogPost});
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 58.0 * height / 1000,
                left: 58 * height / 1000,
                right: 58 * height / 1000,
                bottom: 18 * height / 1000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: LineIcon.angleLeft(
                    size: 30,
                  ),
                ),
                LineIcon.horizontalEllipsis(
                  size: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 58.0 * height / 1000),
            child: Container(
              height: widget.blogPost.title.length >= 22
                  ? height / 10
                  : height / 14,
              width: width,
              child: Text(
                widget.blogPost.title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 25 * height / 700),
              ),
            ),
          ),
          Flexible(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 58.0 * height / 1000,
                ),
                child: Wrap(
                  spacing: 1,
                  children: [
                    CustomChip(
                      tag: widget.blogPost.blogCategoryId.name,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 1 / 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 58.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 1 / 7,
                      height: width * 1 / 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.blogPost.userId.photoSm != ''
                              ? widget.blogPost.userId.photoSm
                              : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.blogPost.userId.name +
                              ' ' +
                              widget.blogPost.userId.surname,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: height * 1 / 180,
                        ),
                        Text(
                          widget.blogPost.date.format(' M j, H:i'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 12 * height / 800),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 1 / 14,
                    ),
                    LineIcon.telegramPlane(
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    LineIcon.bookmark(
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 1 / 20,
              ),
              Column(
                children: [
                  Hero(
                    tag: widget.blogPost.id,
                    child: Container(
                      width: double.infinity,
                      height: height * 1 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl: widget.blogPost.photo != ''
                              ? widget.blogPost.photo
                              : 'https://www.etmd.org.tr/wp-content/uploads/2020/01/YTU_IEEE.jpg',
                          errorWidget: (context, url, error) => Image.network(
                              'https://www.etmd.org.tr/wp-content/uploads/2020/01/YTU_IEEE.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 1 / 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Text(
                      widget.blogPost.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: height * 1 / 60,
                  ),
                  Html(
                    data: widget.blogPost.text,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
