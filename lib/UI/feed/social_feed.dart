import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';

import 'package:like_button/like_button.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/Functions/image_picker.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/UI/feed/add_to_feed.dart';
import 'package:my_app/UI/feed/single_comment.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum FeedState { INITIAL, SENDING, DONE }
XFile? imageFile;
String text = '';
bool sendingPost = false;

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
  List<Post> postList = [];

  PanelController _panelController = PanelController();
  DateTime date = DateTime.now();
  FeedState state = FeedState.INITIAL;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.posts.first.date.toString());
    getAllPosts(postList).then((value) {
      value.forEach((post) {
        if (!widget.posts.contains(post)) {
          setState(() {
            widget.posts.insert(0, post);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: Color(0xFFF8FAFF),
          child: Scaffold(
            floatingActionButton: GestureDetector(
              onTap: () {
                _panelController.open();
              },
              child: Container(
                width: width * 1 / 5,
                height: height * 1 / 20,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: state == FeedState.INITIAL
                      ? LineIcon.plus(
                          color: Theme.of(context).backgroundColor,
                        )
                      : Icon(FontAwesomeIcons.chevronLeft),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.posts[index].date
                                        .format('m/j/y , H:i'),
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
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  description: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.posts[index].date
                                            .format('m/j/y , H:i'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize: 12 * height / 800),
                                      ),
                                    ],
                                  ),
                                  subTitle: Text(
                                    widget.posts[index].text,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                                        color:
                                            isLiked ? Colors.red : Colors.grey,
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
        ),
        SlidingUpPanel(
          onPanelClosed: () {
            setState(() {
              imageFile = null;
            });
          },
          controller: _panelController,
          minHeight: 0,
          slideDirection: SlideDirection.UP,
          maxHeight: height / 2,
          panel: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(FontAwesomeIcons.chevronRight, color: Colors.white),
              onPressed: () async {
                setState(() {
                  sendingPost = true;
                });
                var prefs = await SharedPreferences.getInstance();
                String token = (prefs.getString('token'))!;

                await writePost(
                        imageFile != null ? File(imageFile!.path) : null,
                        text,
                        token)
                    .then((value) {
                  Post newPost = new Post(
                    date: DateTime.parse(value['date']),
                    id: value['_id'],
                    likeCount: 0,
                    liked: false,
                    photo: value["photo"] != null ? value['photo'] : '',
                    text: value['text'],
                    userId: UserModelForPost(
                      id: value['userId']['_id'],
                      photo: value['userId']['photoXs'] != null
                          ? value['userId']['photoXs']
                          : '',
                      name: value['userId']['name'],
                      surname: value['userId']['surname'],
                      username: value['userId']['username'],
                    ),
                    v: value['__v'],
                  );
                  widget.posts.insert(0, newPost);
                  setState(() {
                    sendingPost = false;

                    _panelController.close();
                  });
                });
              },
            ),
            body: ModalProgressHUD(
              opacity: 0,
              progressIndicator: Center(
                child: LoadingBouncingGrid.circle(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              inAsyncCall: sendingPost,
              child: Container(
                height: height / 2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: height / 3.5,
                          width: width,
                          child: Padding(
                            padding: EdgeInsets.all(38.0 * height / 1000),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Yazı',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                TextField(
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(180),
                                  ],
                                  onChanged: (value) => text = value,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 17 * height / 700),
                                  textAlignVertical: TextAlignVertical.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    imageFile != null
                        ? Center(
                            child: Image.file(
                                File(
                                  imageFile!.path,
                                ),
                                height: height / 4),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImageFromCamera().then((value) {
                                      setState(() {
                                        imageFile = value;
                                      });
                                    });
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.camera,
                                    color: Theme.of(context).primaryColor,
                                    size: 60 * height / 1000,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    getImageFromGallery().then((value) {
                                      setState(() {
                                        imageFile = value;
                                      });
                                    });
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.image,
                                    color: Theme.of(context).primaryColor,
                                    size: 60 * height / 1000,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
