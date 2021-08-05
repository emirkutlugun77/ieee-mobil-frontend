import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';

import 'package:like_button/like_button.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/UI/feed/add_to_feed.dart';
import 'package:my_app/UI/feed/single_comment.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class SocialFeed extends StatefulWidget {
  List<Post> posts;
  String token;
  SocialFeed({
    required this.posts,
    required this.token,
  });
  @override
  _SocialFeedState createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFFF8FAFF),
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddToFeed()));
          },
          child: Container(
            width: width * 1 / 5,
            height: height * 1 / 20,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: LineIcon.plus(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 58.0 * height / 1000,
                left: 58.0 * height / 1000,
                right: 58.0 * height / 1000,
              ),
              child: Row(
                children: [
                  Text(
                    'Pano',
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.posts.length,
                  itemBuilder: (context, index) {
                    if (widget.posts[index].photo == '') {
                      return GFListTile(
                          avatar: GFAvatar(
                            backgroundImage: NetworkImage(widget
                                        .posts[index].userId.photo !=
                                    ''
                                ? widget.posts[index].userId.photo
                                : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                            shape: GFAvatarShape.standard,
                          ),
                          title: Text(
                            widget.posts[index].userId.name +
                                ' ' +
                                widget.posts[index].userId.surname,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          description: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.posts[index].date.format('M j, H:i'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 12 * height / 800),
                              ),
                              GFButtonBadge(
                                color: Color(0xFFF8FAFF),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SingleComment()));
                                },
                              ),
                            ],
                          ),
                          subTitle: Text(
                            widget.posts[index].text,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          icon: LikeButton(
                            likeCount: widget.posts[index].likeCount,
                            onTap: (isLiked) async {
                              onLikeButtonTapped(isLiked,
                                  widget.posts[index].id, widget.token);
                              return !isLiked;
                            },
                            isLiked: widget.posts[index].liked,
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.red,
                              dotSecondaryColor: Colors.redAccent,
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                FontAwesomeIcons.solidHeart,
                                color: isLiked ? Colors.red : Colors.grey,
                                size: 30,
                              );
                            },
                          ));
                    } else {
                      return Column(
                        children: [
                          GFListTile(
                              avatar: GFAvatar(
                                backgroundImage: NetworkImage(widget
                                            .posts[index].userId.photo !=
                                        ''
                                    ? widget.posts[index].userId.photo
                                    : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                                shape: GFAvatarShape.standard,
                              ),
                              title: Text(
                                widget.posts[index].userId.name +
                                    ' ' +
                                    widget.posts[index].userId.surname,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              description: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.posts[index].date.format('M j, H:i'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 12 * height / 800),
                                  ),
                                ],
                              ),
                              subTitle: Text(
                                widget.posts[index].text,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              icon: LikeButton(
                                onTap: (isLiked) async {
                                  onLikeButtonTapped(isLiked,
                                      widget.posts[index].id, widget.token);
                                  return !isLiked;
                                },
                                isLiked: widget.posts[index].liked,
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Colors.red,
                                  dotSecondaryColor: Colors.redAccent,
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: isLiked ? Colors.red : Colors.grey,
                                    size: 30,
                                  );
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 18.0, left: 18.0, right: 18),
                            child: CachedNetworkImage(
                              imageUrl: widget.posts[index].photo,
                            ),
                          )
                        ],
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
