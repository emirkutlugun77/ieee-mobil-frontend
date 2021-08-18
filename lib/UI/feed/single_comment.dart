import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';

class SingleComment extends StatelessWidget {
  const SingleComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        color: Color(0xFFF8FAFF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 58.0 * height / 1000,
                left: 38.0 * height / 1000,
                right: 38.0 * height / 1000,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width * 2 / 3,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFAvatar(
                            backgroundImage: AssetImage('images/emir.jpeg'),
                            shape: GFAvatarShape.standard,
                          ),
                        ),
                        Container(
                          width: width * 1 / 2,
                          child: Text(
                            'Emir Kutlugün  ${DateTime.now().format('m/j/y , H:i')}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: LineIcon.angleLeft()),
                ],
              ),
            ),
            SizedBox(height: height / 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.0 * height / 1000),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing amet, consectetur adipiscin',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
              ),
            ),
            SizedBox(
              height: height * 1 / 40,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0 * height / 1000,
                ),
                child: Divider(
                  color: Colors.black,
                  height: 3,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text('Cevaplar',
                      style: Theme.of(context).textTheme.headline1),
                ),
              ],
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
                          DateTime.now().format('m/j/y , H:i'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 12 * height / 800),
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
