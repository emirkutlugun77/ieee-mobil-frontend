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
                bottom: 38 * height / 1000),
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
              height: height / 12,
              width: width,
              child: Text(
                widget.blogPost.title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          SizedBox(
            height: height * 1 / 400,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 5),
            child: Wrap(
              spacing: 10,
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.blogPost.userId.photoSm != ''
                          ? widget.blogPost.userId.photoSm
                          : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
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
                          child: Image.network(
                            widget.blogPost.photo != ''
                                ? widget.blogPost.photo
                                : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
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
                    Container(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Html(
                              data: widget.blogPost.text.toString(),
                            )))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
