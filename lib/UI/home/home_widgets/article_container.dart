import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/UI/article/article_widgets/chip.dart';
import 'package:my_app/UI/models/blogposts.dart';

class ArticleContainer extends StatelessWidget {
  final BlogPost blogPost;

  const ArticleContainer({
    Key? key,
    required this.blogPost,
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
            tag: blogPost.id,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Image.network(
                  blogPost.photo != ''
                      ? blogPost.photo
                      : 'https://ae01.alicdn.com/kf/HTB1kBs1IFXXXXXuXXXXq6xXFXXXD/Fine-oil-painting-on-canvas-Vincent-Van-Gogh-The-Starry-Night-moon-landscape-canvas.jpg_Q90.jpg_.webp',
                  fit: BoxFit.fill,
                  width: width * 1 / 4.5,
                  height: height * 1 / 4,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(18.0 * height / 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: width * 1 / 2,
                    child: Text(
                        blogPost.title.length >= 21
                            ? blogPost.title.substring(0, 21) + '...'
                            : blogPost.title,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14 * height / 700,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w100)),
                  ),
                ),
                SizedBox(
                  height: height * 1 / 100,
                ),
                Text(
                  blogPost.userId.name + ' ' + blogPost.userId.surname,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 13 * height / 700),
                ),
                SizedBox(
                  height: height * 1 / 100,
                ),
                Container(
                    height: height * 1 / 20,
                    child: CustomChip(tag: blogPost.blogCategoryId.name)),
                SizedBox(
                  height: height * 1 / 100,
                ),
                Flexible(
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LineIcon.thumbsUp(
                          color: Theme.of(context).cardColor,
                          size: height / 25,
                        ),
                        Text(
                          blogPost.likedBy.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 14 * height / 700),
                        ),
                        SizedBox(
                          width: width * 1 / 120,
                        ),
                        LineIcon.clock(
                          color: Theme.of(context).cardColor,
                          size: height / 25,
                        ),
                        Text(
                          blogPost.date.format(' M j, H:i'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 14 * height / 700),
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
