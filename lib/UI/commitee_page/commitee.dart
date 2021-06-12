import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/UI/event/single_event.dart';

class ComiteePage extends StatefulWidget {
  final String image;
  final int index;
  const ComiteePage({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  _ComiteePageState createState() => _ComiteePageState();
}

class _ComiteePageState extends State<ComiteePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 58.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'commiteePic${widget.index}',
                        child: Image.asset(widget.image),
                      ),
                      Positioned(
                          top: 20,
                          left: 20,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: LineIcon.arrowLeft())),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'CS',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 40,
                      ),
                      Text('Koordinasyon Ekibi',
                          style: Theme.of(context).textTheme.headline2),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                      ),
                      Text('Komite Başkanı:',
                          style: Theme.of(context).textTheme.bodyText2),
                      Text('Emir Kutlugün',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 80,
                      ),
                      Text('Komite Başkan Yardımcısı:',
                          style: Theme.of(context).textTheme.bodyText2),
                      Text('Cemre Kılıç',
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Text('Hakkımızda:',
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Wrap(children: [
                Text(
                    'IEEE YTU Computer Society’nin temel amacı, bilgisayar ile da bulunmaktadır.IEEE YTU Computer Society’nin temel amacı, bilgisayar ile da bulunmaktadır.IEEE YTU Computer Society’nin temel amacı, bilgisayar ile da bulunmaktadır.IEEE YTU Computer Society’nin temel amacı, bilgisayar ile da bulunmaktadır...',
                    style: Theme.of(context).textTheme.bodyText1),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          if (Platform.isIOS) {
                            return CupertinoAlertDialog(
                              title: Text('Hakkımızda'),
                              content: Text(
                                  'IEEE YTU Computer Society’nin temel amacı, bilgisayar ile ilgilenen üyelerin projeler üzerinden bilgisayar ve bilgi işleme teknolojisine dayalı yeteneklerini geliştirmesine imkân sağlayacak ortamı sağlamaktır. Bunların yanısıra kulübün ihtiyacı olan teknik desteği sağlamaktadır. Farklı programlama dillerinde uygulama ve algoritma geliştirmeyi amaçlayan komite, projelerin geliştirilmesine katkıda bulunmanın yanısıra üyelerin ihtiyaç duyduğu mentörlük, eğitim ve tartışma ortamını sağlamak amacıyla birçok faaliyette bulunmaktadır. Yıl içerisinde düzenlenen çeşitli workshop’lar, etkinlikler ve eğitimler ile birlikte üyelerin yazılım ve bilişim konusunda kendilerini geliştirmelerine katkıda bulunmaktadır.'),
                            );
                          } else {
                            return AlertDialog(
                              title: Text('Hakkımızda'),
                              content: Text(
                                  'IEEE YTU Computer Society’nin temel amacı, bilgisayar ile ilgilenen üyelerin projeler üzerinden bilgisayar ve bilgi işleme teknolojisine dayalı yeteneklerini geliştirmesine imkân sağlayacak ortamı sağlamaktır. Bunların yanısıra kulübün ihtiyacı olan teknik desteği sağlamaktadır. Farklı programlama dillerinde uygulama ve algoritma geliştirmeyi amaçlayan komite, projelerin geliştirilmesine katkıda bulunmanın yanısıra üyelerin ihtiyaç duyduğu mentörlük, eğitim ve tartışma ortamını sağlamak amacıyla birçok faaliyette bulunmaktadır. Yıl içerisinde düzenlenen çeşitli workshop’lar, etkinlikler ve eğitimler ile birlikte üyelerin yazılım ve bilişim konusunda kendilerini geliştirmelerine katkıda bulunmaktadır.'),
                            );
                          }
                        });
                  },
                  child: Text('Tamamını Oku',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor)),
                )
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Text('Etkinlikler:',
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 58.0, top: 28),
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingleEvent(index: index)));
                        },
                        child: Hero(
                          tag: 'event${index + 1}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'images/ev${index + 1}.jpg',
                              fit: BoxFit.fitHeight,
                              width:
                                  MediaQuery.of(context).size.width * 1 / 2.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ))
          ]),
        ));
  }
}
