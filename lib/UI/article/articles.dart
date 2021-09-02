import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_app/Functions/blog.dart';

import 'package:my_app/UI/article/article_page.dart';

import 'package:my_app/UI/home/home_widgets/article_container.dart';
import 'package:my_app/UI/models/blogposts.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class Articles extends StatefulWidget {
  List<BlogPost> blogPosts;
  final String token;
  Articles({
    required this.token,
    required this.blogPosts,
  });
  @override
  _ArticlesState createState() => _ArticlesState();
}

bool loading = true;

class _ArticlesState extends State<Articles> {
  int page = 0;
  @override
  void initState() {
    super.initState();
    print(widget.token);
    print(widget.blogPosts[0].liked);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 58.0 * height / 1000,
                  left: 58 * height / 1000,
                  right: 58 * height / 1000),
              child: Row(
                children: [
                  Text(
                    'Makaleler',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmartRefresher(
                  enablePullUp: true,
                  enablePullDown: false,
                  onLoading: _onLoading,
                  controller: _refreshController,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.blogPosts.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticlePage(
                                          token: widget.token,
                                          blogPost: widget.blogPosts[index],
                                        )));
                          },
                          child: ArticleContainer(
                              token: widget.token,
                              blogPost: widget.blogPosts[index],
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height)),
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

  void _onLoading() async {
    page++;
    // monitor network fetch

    await getMost5(widget.blogPosts, widget.token, page);

    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}
