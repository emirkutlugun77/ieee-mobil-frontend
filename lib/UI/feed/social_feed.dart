import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/UI/feed/add_to_feed.dart';
import 'package:my_app/UI/feed/single_comment.dart';

class SocialFeed extends StatelessWidget {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFFF8FAFF),
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () async {
            getAllPosts();
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
                itemCount: 15,
                itemBuilder: (context, index) => GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('images/emir.jpeg'),
                      shape: GFAvatarShape.standard,
                    ),
                    title: Text(
                      'Emir Kutlugün',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    description: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date.format('M j, H:i'),
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
                                    builder: (context) => SingleComment()));
                          },
                          text: "Yorumlar",
                          textColor: Colors.black,
                          icon: GFBadge(
                            child: Text("12"),
                          ),
                          size: GFSize.SMALL,
                        ),
                      ],
                    ),
                    subTitle: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    icon: LineIcon.heart()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
