import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                          data:
                              "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yalan makinesi uzmanı ABD’li elektronikçi Cleve Backster bir gece eğlence olsun diye yalan makinesi elektrotlarını tropikal bir bitkinin yapraklarına yerleştirdi. Yalan makinesinin çeşitli sevinç, korku, şaşkınlık durumlarının yol açtığı elektriksel değişimleri ölçtüğünü göz önünde bulundurarak elektrotları bağladığı bitkiye bu durumları yaşatmaya başladı.</p><p> İlk olarak sulanırsa sevineceğini düşünerek bitkiyi suladı. Backster’ın varsayımlarına göre galvanometrede yukarı yönlü bir hareket gözlenmeliydi, fakat bitki beklediği tepkinin tam tersini vererek zikzaklar çizerek aşağı doğru indi. Şaşkınlıkla galvanometreyi izleyen Backster kibriti alıp bitkiyi yakmayı düşündüğünde bitki çılgınca galvanometrenin ibresini tavan yaptırdı. Bitkinin bu tepkisi Backster’ın şaşkınlığını ikiye katladı çünkü kendisi henüz bu eylemi gerçekleştirmemiş, sadece aklından geçirmişti. Yoksa bitkiler düşüncelerimizi okuyabiliyor muydu?</p><p>&nbsp; Bu olayı bir sürü deney takip etti ve alınan sonuçlar inanılmazdı. Yapılan deneyler bize bitkilerin sadece düşüncelerimizi okumakla kalmayıp çevrelerindeki her şeyi hissettiklerini de gösterdi. Kaynar suya atılan karideslerin ölümlerini, eline iğne battığında duyulan acıyı da hissediyordu bitkiler. Kilometrelerce ötede olunsa bile yaşanan sevinç ve üzüntüleri de hissediyor hatta korkudan baygınlık bile geçiriyorlardı.</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bir gün şehir dışından gelen bir botanikçi içeri girdiğinde bütün bitkiler sessizleşti. Hiçbirinden tepki gelmiyordu. Sanki hepsi birden sessizliğe bürünmüştü. Botanikçi havaalanından uçağa binip gittikten 45 dakika sonra yeniden tepki vermeye başladılar. Backster bitkilerin botanikçiyi görünce korkudan bayıldıklarını, botanikçinin bitkileri kurutup ölçümler yaptığını öğrendiği zaman anladı. Bunun üzerine Backster “Acaba bitkilerin hafızası var mı?” sorusuna cevap arayan bir deney tasarladı. 6 yardımcısına aynı gece aynı saatlerde yapmak üzere farklı görevler verdi. Görevlerden biri gece yarısı gelip laboratuvardaki bitkilerden birini söküp parçalamaktı. Ertesi gün o gece bitkiyi parçalayan yardımcı içeri girdiğinde ibrelerin hepsi tavan yapmaya başladı. Cleve Backster ise bunu “bitkilerin çılgınlar gibi bağırması” olarak kaydetti. Bu deney bitkilerin sadece hissetmeyip, aynı zamanda hafızalarının da olduğunu kanıtladı.</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bu çalışmalar makale olarak yayınlanmaya başlayınca dünyanın dört bir yanından bilim insanları konu üzerinde çalışmalara başladılar ve akıl almaz sonuçlara ulaştılar. Koparılmış bir yaprak, kendisine güzel sözler söylenmesi durumunda normal yapraktan aylarca daha uzun süre canlı kalabiliyor. 120 km mesafedeki bir acıyı, sevinci hissedebiliyor. İnsanların düşüncelerini okuyabiliyor, kötülük yapanları hafızasına kaydedebiliyor. Aynı zamanda bu bilgileri diğer bitkilerle de paylaşıyor. Kendisine kötü davranılan bitki üzüntüsünden intihar bile ediyor. Yanındaki bitkinin susuz kalması durumunda kendi suyunu onunla paylaşıyor.</p><p> Bitkiler, bütün canlılarla iletişim kurma konusunda bizim hayallerimizin ötesinde bir hassasiyete sahip. Bütün bu veriler bizi basit bir soruya götürüyor; “Bitkilerin beyni var mıdır?” Sorumuzun cevabı elbette “Hayır.” Bitkilerin beyni ve sinir sistemleri yok. Ama bitkilerde bizim gibi elektriği kullanarak iletişim kurma yeteneğine sahipler.</p><p></p><p><strong>Detaylı bilgi almak adına dilerseniz bu videolara da göz atabilirsiniz:</strong></p><p>Backster Deneyleri: </p><p></p><iframe src="),
                    ))
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
