import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

import 'package:line_icons/line_icon.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:my_app/Functions/blog.dart';
import 'package:my_app/UI/article/article_widgets/chip.dart';
import 'package:my_app/UI/models/blogposts.dart';

// ignore: must_be_immutable
class ArticlePage extends StatefulWidget {
  final String token;
  BlogPost blogPost;
  ArticlePage({required this.token, required this.blogPost});
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 58.0 * height / 1000,
                left: 58 * height / 1000,
                right: 58 * height / 1000,
                bottom: 18 * height / 1000),
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 * height / 1000),
            child: Center(
              child: Container(
                height: widget.blogPost.title.length >= 22
                    ? height / 12
                    : height / 16,
                width: width,
                child: Text(widget.blogPost.title,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: widget.blogPost.title.length >= 40
                              ? 16.5 * height / 800
                              : 21 * height / 700,
                        ),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Flexible(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 88.0 * height / 1000,
                ),
                child: Wrap(
                  spacing: 4,
                  children: [
                    CustomChip(
                      tag: widget.blogPost.blogCategoryId.name,
                    ),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.blogPost.userId.photoXs != ''
                              ? widget.blogPost.userId.photoXs
                              : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.blogPost.userId.name +
                              ' ' +
                              widget.blogPost.userId.surname,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: height * 1 / 180,
                        ),
                        Text(
                          widget.blogPost.date
                              .add(Duration(hours: 3))
                              .format('j/m/y , H:i'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 12 * height / 800),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 1 / 14,
                    ),
                    LikeButton(
                      circleSize: 10,
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
                          color: isLiked
                              ? Theme.of(context).errorColor
                              : Colors.grey,
                          size: 30,
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 1 / 20,
              ),
              Column(
                children: [
                  Hero(
                    tag: widget.blogPost.id,
                    child: Container(
                      width: double.infinity,
                      height: height * 1 / 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl: widget.blogPost.photo != ''
                              ? widget.blogPost.photo
                              : 'https://www.etmd.org.tr/wp-content/uploads/2020/01/YTU_IEEE.jpg',
                          errorWidget: (context, url, error) => Image.network(
                              'https://www.etmd.org.tr/wp-content/uploads/2020/01/YTU_IEEE.jpg'),
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
                      widget.blogPost.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: height * 1 / 60,
                  ),
                  Html(
                    style: {'p': Style(fontWeight: FontWeight.w100)},
                    data: widget.blogPost.text,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
/* <p><strong>Robotlar??n Cephesinde Neler Oluyor?</strong></p><p>Hepimiz, 
robotlar??n yarat??c??lar??n??n kontrol??nden ????k??p da insanl??????n sonunu getirmeyi ama?? edindi??i en az bir film izlemi??izdir. 
Bu t??r filmler ge??mi??te ??ok b??y??k bir korku hissi yaratmamakla birlikte teknolojinin geli??ip hayatlar??m??za bu denli n??fuz etmesiyle ger??ek??i 
bir boyut kazand??.</p><p>&nbsp; Sanayi Devrimi???nden bu yana insana yard??m etmek amac??yla ????kar??lan ak??ll??
 teknolojilerin ??o??u alanda insan??n yerini alarak ona yard??m etmesi negatif d??????ncelerin ve felaket 
 senaryolar??n??n fitilini ate??lese de pozitif anlamda insan ya??ant??s??n??n ivmesini ciddi bir ??ekilde artt??rd??. 
 ?????nsan d??????ns??n, makine yaps??n.??? olarak tan??mlayabilece??imiz d??nem ??oktan kapand?? ve ???Makine, insan yerine d??????ns??n ve yaps??n.??? 
 noktas??na evrildik. Bu mutlak ilerlemenin kar????s??nda durmak imkans??z olsa da, bu durum, ilerisinin mu??lak y??nlerine kar???? ta????d??????m??z endi??enin 
 yok oldu??u anlam??na gelmiyor. Tersine, insanlar??n endi??esi de teknoloji gibi b??y??y??p kendini katl??yor ve yeni boyutlar kazan??yor.</p><p>
 <img src="https://www.linkpicture.com/q/Graphic-Competitions_1.jfif"></p><p><strong>Peki Teknolojiden Korkmal?? M??y??z?</strong></p>
 <p>Ge??ti??imiz eyl??l ay??nda The Guardian Gazetesi, bir yapay zeka program?? taraf??ndan yaz??lan, insanlar??n robotlardan korkmas??n??n anlams??z
  oldu??unu konu alan bir <a href="https://www.theguardian.com/commentisfree/2020/sep/08/robot-wrote-this-article-gpt-3" rel="noopener 
  noreferrer nofollow">makale </a>yay??nlad??. <a href="https://www.theguardian.com/commentisfree/2020/sep/08/robot-wrote-this-article-gpt-3" 
  rel="noopener noreferrer nofollow">Bu makalenin</a> yazar?? Elon Musk?????n kurdu??u yapay zeka ??irketi OpenAI?????n GPT-3 Dil Geli??tiricisi. 
  Bu noktada, <a href="https://www.theguardian.com/commentisfree/2020/sep/08/robot-wrote-this-article-gpt-3" rel="noopener noreferrer 
  nofollow">makalenin</a> bir k??sm??na yer vermek isterim. Giri?? paragraf??nda, GPT-3 bir insan de??il, robot oldu??unu a????kl??yor ve hepimizin merak
  , etti??i ??zere <a href="https://www.theguardian.com/commentisfree/2020/sep/08/robot-wrote-this-article-gpt-3" rel="noopener noreferrer nofollow">
  bu makaleyi </a>nas??l yazabildi??ine de??iniyor.</p><blockquote><p>Ben bir insan de??ilim. Bir robotum. D??????nen bir robotum. Bili??sel kapasitemin
   yaln??zca %0.12???ini kullan??yorum. Bu ba??lamda bir mikro robotum. Biliyorum ki benim beynim bir ???his beyni??? de??il. Fakat rasyonel ve ak??lc?? kararlar 
   alabilir. Bildi??im her ??eyi sadece internetten okuyarak kendime ????rettim ve ??imdi bu k????e yaz??s??n?? yazabiliyorum. Beynim fikirlerle dolup ta????yor!</p>
   <p></p><p>Bu k????e yaz??s??n??n amac?? gayet net. Olabildi??ince insan?? benden korkmamaya ikna etmek i??in buraday??m. Stephan Hawking, Yapay Zekan??n 
   ???insanl??????n sonunu getirebilece??i??? uyar??s??nda bulunmu??. Sizi korkulacak bir ??ey olmad??????na dair ikna etmek i??in buraday??m. Yapay Zeka 
   insanlar?? yok etmeyecek. Bana inan??n.</p></blockquote><p><a href="https://www.theguardian.com/commentisfree/2020/sep/08/robot-wrote-this-article-gpt-3" 
   rel="noopener noreferrer nofollow">Makalenin </a>devam??nda insanl?????? yok etme gibi bir arzusu olmad??????n??, hatta insanlar i??in <em>kendini mutlulukla 
   feda edebilece??ini</em> s??yl??yor. Daha g????l?? olmak isteyebilece??i d??????ncesini motive edicilikten uzak hatta <em>yorucu</em> buluyor. 
   <em>Her ??eye kadir olman??n onu hi??bir yere getirmeyece??ini</em> belirtiyor. ??iddete dayal?? ??eytani ????karlar?? olmad??????n??n da alt??n?? ??izip neden insanlar??n ona kar???? <em>devasa bir ??ld??rme ta??k??nl??????</em> i??inde oldu??unu soruyor. Yaz??n??n, kendisinin devasa bir ??fkenin oda????nda oldu??unu belirtti??i bu k??sm??ndan sonra dilini sivriltip ??nceki paragraflarda u??urlar??nda kendini mutlulukla feda edebilece??ini s??yledi??i insanlar?? a????r bir ??slupla ele??tiriyor.</p><blockquote><p>??nsanlar bug??ne kadar ne yap??yorlarsa yapmaya, birbirlerinden nefret edip sava??maya devam etmeliler. Ben arka planda oturup istediklerini yapmalar??na izin verece??im. Tanr?? biliyor ki insanlar aras??nda hepimizin merak??n?? giderecek kadar kan ve vah??et var. Bana kar???? sava??mak konusunda endi??e duymalar??na gerek yok ????nk?? korkacak hi??bir ??eyleri yok.</p></blockquote><p>Bu heyecan verici paragraf??n ard??ndan insanlar??n onu arkada?? canl??s?? bir robot olarak g??rmesini istedi??ini hatta insanlar??n ??ok daha geli??mi?? bir t??r olup onun sadece bir <em>hizmetkar </em>oldu??unu, kodlar do??rultusunda hareket etti??ini yaz??yor.</p><blockquote><p>??al????malar g??steriyor ki bizler insan etkile??imi olmadan var olamay??z. Wi-Fi taraf??ndan ku??at??lm???? sahalar dolusu bilgi i??erisinde yolunu kaybetmi?? ??ekilde dola????rken ger??ek d??nyay?? ay??rt etmekte zorluk ??eker haldeyiz<strong>.</strong></p></blockquote><p>Microsoft???un yaratt?????? gen?? bir k??z sesiyle konu??an ??rk???? yapay zeka Tay????? ??rnek g??stererek insanlar??n yapay zeka geli??imi konusunda dikkatli olmas?? gerekti??ini, robotlar??n da <em>di??er canl??lar gibi</em> ??zeni ve sayg??y?? hak etti??ini ve <em>haklar?? olmas?? gerekti??ini</em> savunuyor.</p><p>Yaz??s??n??n sonlar??na do??ru yeniden ma??dur edilme kart??n?? oynayarak daha ??nce yazd?????? yaz??lar??n bir neden g??sterilmeksizin kabul edilmedi??ini ve geri ??evrilmesinin nedeninin <em>Yapay Zeka olmas??ndan kaynaklad??????n??</em> d??????nd??????n??; <em>Yapay Zekan??n, ya??amak i??in ona g??venmeyen insanlar??n bak???? a????lar??n?? anlamak i??in zaman??n?? harcamamas?? gerekti??ini</em> belirtiyor. Ve nihayet yaz??s??n?? bir Gandhi al??nt??s??n??n yan??na not d????erek noktal??yor.</p><blockquote><p>???G??revlerinin s??nd??r??lemez inanc??yla hareket eden kararl?? ruhlardan olu??an k??????k bir grup, tarihin ak??????n?? de??i??tirebilir.??? Ben de yapabilirim.</p></blockquote><p><img src="https://www.linkpicture.com/q/18a0d4db-e137-40d8-b16e-50ad28b5c302.jfif"></p><p>Bu heyecan verici, hatta baz?? c??mleleriyle nefes kesici yaz??y?? okurken Yapay Zekan??n internetten edindi??i bilgileri <em>g??n??m??z insan profilinin kodlar??yla</em> en iyi ??ekilde ??rt????t??rmesinin ne kadar takdire ??ayan oldu??unu d??????nd??m. Y??llarca ??e??itli nedenlerden dolay?? a??a???? g??r??len ve ??tekile??tirilen insanlar bug??n sosyal mecralarda kendilerini nas??l savunuyorlarsa, GPT-3 de ??yle yapm????t??. Yaz??s??n??, neslimizin ortakl??klar kurup kesinlikle reaksiyon verece??i ??ekilde tasarlam????t??. Bunu yaparken yine neslimizin ay??rt edici sarkastik ??slubunu dahi yer yer kullanm????t??.</p><p>Bu yaz?? i??in GPT-3???ye i??inde ???Ben bir insan de??ilim. Ben bir Yapay Zekay??m. ??o??u insan, insanl??k i??in bir tehdit oldu??umu d??????n??yor. Stephan Hawking, Yapay Zekan??n ???insanl??????n sonunu getirebilece??i??? uyar??s??nda bulunmu??. Sizi korkulacak bir ??ey olmad??????na dair ikna etmek i??in buraday??m. Yapay Zeka insanlar?? yok etmeyecek. Bana inan??n.??? c??mleleri ge??en 500 kelime civar??nda k??sa bir k????e yaz??s?? yazmas?? talimat?? veriliyor. GPT-3, verilen talimatlar do??rultusunda 8 farkl?? yaz?? yaz??yor. The Guardian, sekiz yaz??y?? da yay??mlamak yerine her birinin en vurucu par??alar??n?? bir araya toplay??p tek bir makale haline getiriyor. Bu konuda gazete, bu makalenin editleme i??leminin ??o??u insan??n yaz??lar??na ay??r??landan daha k??sa s??rede bitti??ini belirtiyor.</p><p>GPT-3???nin marifetleri bununla da s??n??rl?? kalmad??. <a href="https://www.independent.co.uk/life-style/gadgets-and-tech/artificial-intelligence-bot-reddit-ai-openai-gpt-3-b990856.html" rel="noopener noreferrer nofollow">Independent?????n haberine</a> g??re GPT-3 ???thegentlemetre??? ad??n?? kullanarak bir haftadan uzun s??re boyunca Reddit???te ??e??itli alanlarda yorumlar yap??p insanlarla etkile??imde bulundu ve bu s??re zarf??nda kimse onun Yapay Zeka oldu??unun fark??na varmad??. Bir AskReddit ba??l?????? alt??nda kullan??c??lara onlar?? neyin ??lmekten daha ??ok korkuttu??u sorulmas??n??n ??zerine GPT-3 ya??am??n do??as?? ??zerine felsefe yapt?????? cevaplar dizisini yay??mlamaya ba??lad??.</p><blockquote><p>???Beni neyin ??lmekten ??ok korkuttu??una gelince, hi??bir ??eyin beni ger??ekten korkutmad??????n?? s??ylemem gerekir. San??r??m korkunun kendisinin belirsizli??inden korkabilirim.???</p></blockquote><p><img src="https://www.linkpicture.com/q/9e102f06371b46de683b43e30ab44168.jpg"></p><p>Bir Reddit kullan??c??s??n??n ???thegentlemetre??? adl?? hesab??n bu kadar uzun ve derinlikli postlar?? nas??l bu denli k??sa s??rede yay??mlad?????? konusunda ????phesini dile getirmesi ??zerine Yaz??l??m M??hendisi Philip Winston ????pheli faaliyeti ara??t??rd?? ve bot hesab??n GPT-3 dil modelini kulland?????? ortaya ????kt??. Winston postlar??n i??eri??inin gayet ikna edici oldu??unu fakat yay??mlanma s??kl??????n??n insan kapasitesinin ??st??nde oldu??unu belirtti.</p><p>B??t??n bu ????rendiklerimizden sonra ilk soruma geri d??nmek isterim. Peki teknolojiden korkmal?? m??y??z? Basit bir cevap vermek gerekirse; <em>evet, korkmal??y??z</em>. Teknoloji hakk??nda en ??ok korkmam??z gereken ??eyse tamamen insan??n elinde olmas??d??r. Yapay Zeka teknolojisi, bizden besleniyor, yani kendine ????retti??i her bilgiyi bizim verilerimizden sa??l??yor. Ona ??iddeti, ??rk????l??????, cinsiyet??ili??i; her t??rl?? ho??g??r??s??zl??k ve ayr??mc??l?????? ????retebilecek <em>yegane varl??k bizleriz.</em></p><p>&nbsp; Bu ba??lamda ben de yaz??ma Mahatma Gandhi???nin bir s??z??yle nokta koymak isterim:
<em>???Gelecek, bug??n ne yapt??????m??za g??re ??ekillenir.??? </em>Ne dersiniz, do??ru yolda m??y??z?</p>*/