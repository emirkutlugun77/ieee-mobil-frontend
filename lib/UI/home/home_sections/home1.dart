import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/UI/article/article_page.dart';
import 'package:my_app/UI/commitee_page/commitee.dart';
import 'package:my_app/UI/home/home_widgets/article_container.dart';
import 'package:my_app/UI/home/home_widgets/carousel_card.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int current = 0;
  CarouselController _carouselController = CarouselController();
  List<ComiteeCard> carouselItems = [
    ComiteeCard(
      imageId: 'images/cas.png',
      comiteeName: 'CAS',
      index: 0,
    ),
    ComiteeCard(
      imageId: 'images/cs.png',
      comiteeName: 'Computer Society',
      index: 1,
    ),
    ComiteeCard(
      imageId: 'images/embs.png',
      comiteeName: 'EMB',
      index: 2,
    ),
    ComiteeCard(
      imageId: 'images/etkinlik.png',
      comiteeName: 'TEGEK',
      index: 3,
    ),
    ComiteeCard(
      index: 4,
      imageId: 'images/uluslar.png',
      comiteeName: 'Uluslararası İlişkiler',
    )
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFFF8FAFF),
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
                  'Hoşgeldin Emir!',
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
          SizedBox(
            height: height * 1 / 30,
          ),
          Container(
            height: height * 2.1 / 5,
            width: double.infinity,
            child: CarouselSlider(
                carouselController: _carouselController,
                items: carouselItems
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ComiteePage(
                                          index: current,
                                          image: carouselItems[current].imageId,
                                        )));
                          },
                          child: e,
                        ))
                    .toList(),
                options: CarouselOptions(
                    onPageChanged: (prev, next) => current = prev,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    enlargeCenterPage: true,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    aspectRatio: 0.9)),
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
                    'Son Yazılar',
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
          SingleChildScrollView(
            child: Container(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ArticlePage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 10),
                    child: ArticleContainer(
                      width: width,
                      height: height,
                      content: lorem(paragraphs: 2),
                      date: DateTime.now(),
                      header: 'Bir Eser, Bir Hikaye',
                      imageId: 'images/resim.png',
                      likes: 10,
                      name: 'Emir Kutlugün',
                      topic:
                          'Sanat şüphesiz hepimize mutluluk aşılayan nadir şeylerden',
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
