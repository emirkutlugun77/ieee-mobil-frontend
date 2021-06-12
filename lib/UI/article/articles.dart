import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:my_app/UI/article/article_page.dart';
import 'package:my_app/UI/home/home_widgets/article_container.dart';

class Articles extends StatelessWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 58.0),
        child: Column(
          children: [
            Row(
              children: [
                Hero(
                    tag: 'son_yazilar',
                    child: Text(
                      'Son Yazılar',
                      style: Theme.of(context).textTheme.headline1,
                    )),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticlePage()));
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 10),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: 12.0 * height / 700),
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
                            ),
                          )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
