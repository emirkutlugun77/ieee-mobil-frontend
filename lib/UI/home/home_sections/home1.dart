import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';

import 'package:my_app/Functions/committee.dart';
import 'package:my_app/UI/article/article_page.dart';
import 'package:my_app/UI/commitee_page/commitee.dart';

import 'package:my_app/UI/home/home_widgets/article_container.dart';

import 'package:my_app/UI/models/blogposts.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/user.dart';

// ignore: must_be_immutable
class Home1 extends StatefulWidget {
  Home1(
      {required this.user, required this.committees, required this.blogPosts});
  User user;
  List<Commitee> committees;
  List<BlogPost> blogPosts;
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int current = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                    onPressed: () {},
                    icon: LineIcon.bell(
                      color: Theme.of(context).cardColor,
                      size: 30,
                    ),
                    type: GFButtonType.transparent,
                  ),
                  counterChild: GFBadge(
                    child: Text("12"),
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
                                    imageUrl: widget.committees[index].photo,
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
              padding: EdgeInsets.symmetric(horizontal: 58.0 * height / 1000),
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
                  Text(
                    'Daha Fazla',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14 * height / 700),
                  )
                ],
              )),
          SizedBox(
            height: height * 1 / 60,
          ),
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.blogPosts.length,
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
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 10),
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
    );
  }
}
