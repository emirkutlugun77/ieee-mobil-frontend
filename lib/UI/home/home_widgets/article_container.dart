import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/Functions/blog.dart';
import 'package:my_app/UI/article/article_widgets/chip.dart';
import 'package:my_app/UI/models/blogposts.dart';

class ArticleContainer extends StatefulWidget {
  String token;
  BlogPost blogPost;
  ArticleContainer({
    required this.token,
    required this.blogPost,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  _ArticleContainerState createState() => _ArticleContainerState();
}

class _ArticleContainerState extends State<ArticleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height * 1 / 5.5,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: widget.blogPost.id,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Image.asset(
                    'images/resim.png',
                    fit: BoxFit.fill,
                    width: widget.width * 1 / 4.5,
                    height: widget.height * 1 / 4,
                  ),
                  imageUrl: widget.blogPost.photo != ''
                      ? widget.blogPost.photo
                      : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                  fit: BoxFit.fill,
                  width: widget.width * 1 / 4.5,
                  height: widget.height * 1 / 4,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(18.0 * widget.height / 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: widget.width * 1 / 2,
                    child: Text(
                        widget.blogPost.title.length >= 21
                            ? widget.blogPost.title.substring(0, 21) + '...'
                            : widget.blogPost.title,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14 * widget.height / 700,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w100)),
                  ),
                ),
                SizedBox(
                  height: widget.height * 1 / 100,
                ),
                Text(
                  widget.blogPost.userId.name +
                      ' ' +
                      widget.blogPost.userId.surname,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 13 * widget.height / 700),
                ),
                SizedBox(
                  height: widget.height * 1 / 100,
                ),
                Container(
                    height: widget.height * 1 / 25,
                    child:
                        CustomChip(tag: widget.blogPost.blogCategoryId.name)),
                SizedBox(
                  height: widget.height * 1 / 70,
                ),
                Flexible(
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LikeButton(
                          likeCount: widget.blogPost.likeCount,
                          onTap: (isLiked) async {
                            likeBlog(isLiked, widget.token, widget.blogPost);

                            widget.blogPost.liked = !isLiked;

                            return !isLiked;
                          },
                          isLiked: widget.blogPost.liked,
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
                        ),
                        SizedBox(
                          width: widget.width * 1 / 120,
                        ),
                        LineIcon.clock(
                          color: Theme.of(context).cardColor,
                          size: widget.height / 25,
                        ),
                        Text(
                          widget.blogPost.date.format(' M j, H:i'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 14 * widget.height / 700),
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
