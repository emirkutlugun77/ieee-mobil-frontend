import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:line_icons/line_icon.dart';

import 'package:my_app/UI/article/article_widgets/chip.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 58.0, left: 58, right: 58, bottom: 38),
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
            padding: const EdgeInsets.symmetric(horizontal: 58.0),
            child: Text(
              'Bir Eser, Bir Hikaye',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            height: height * 1 / 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 5),
            child: Wrap(
              spacing: 10,
              children: [
                CustomChip(
                  tag: 'Sanat',
                ),
                CustomChip(tag: 'Tarih')
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
                    child: Image.asset(
                      'images/emir.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emir Kutlugün',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: height * 1 / 180,
                    ),
                    Text(
                      '29.01.2001',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 1 / 7,
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
                      tag: 'image1',
                      child: Container(
                        width: double.infinity,
                        height: height * 1 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Image.asset(
                            'images/resim.png',
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
                        'Sanat, şüphesiz hepimize mutluluk aşılayan nadir şeylerden.',
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
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: Text(
                          lorem(paragraphs: 5),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    )
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
