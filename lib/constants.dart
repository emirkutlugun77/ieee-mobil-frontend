import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Map<String, Color> blogCategoryColors = {
  'Teknoloji': Color(0xFF4565d9),
  'Kişisel Gelişim': Color(0xFFf7a950),
  'Spor': Color(0xFF27b438),
  'Eğlence': Color(0xFF811d7e),
  'Sanat/Kültür': Color(0xFFb4573e),
  'Kariyer': Color(0xFF0d1d96),
  'Bilim': Color(0xFF33b9db),
  'Seyahat': Color(0xFFa21a1a),
  'Kulüp Haberleri': Color(0xFF0f0f0f),
  'Röportaj': Color(0xFF73a441),
  'Tarih': Color(0xFF2DAE31)
};

ThemeData whiteTheme = ThemeData(
    iconTheme: IconThemeData(color: Colors.black),
    brightness: Brightness.light,
    primaryColor: Color(0xFF376AED),
    primaryColorDark: Color(0xFF2151CD),
    primaryColorLight: Colors.grey.shade50,
    cardColor: Color(0xFF0D253C),
    bottomAppBarColor: Color(0xFF7B8BB2),
    accentColor: Color(0xFF8FE6FF),
    splashColor: Color(0xFF127C12),
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: GoogleFonts.inter(
          fontSize: 14, color: Color(0xFF0D253C), fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.inter(
          fontSize: 16, color: Color(0xFF0D253C), fontWeight: FontWeight.w600),
      headline1: GoogleFonts.inter(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0D253C),
      ),
      headline2: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0D253C),
      ),
      headline3: GoogleFonts.inter(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline4: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      subtitle1: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Color(0xFF2D4379),
      ),
      subtitle2: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF2D4379),
      ),
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    primaryColorDark: Color(0xFF5865F2),
    primaryColorLight: Color(0xFF2C2F33),
    primaryColor: Color(0xFF7289DA),
    cardColor: Color(0xFF0D253C),
    bottomAppBarColor: Color(0xFF7B8BB2),
    accentColor: Color(0xFF8FE6FF),
    splashColor: Color(0xFF127C12),
    errorColor: Color(0xFFEB459E),
    backgroundColor: Color(0xFF23272A),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.inter(
          fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.inter(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      headline1: GoogleFonts.inter(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      headline3: GoogleFonts.inter(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline4: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      subtitle1: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      subtitle2: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ));

String privacyPolicy =
    '''SİTE KULLANIM ŞARTLARI Lütfen sitemizi kullanmadan evvel bu ‘site kullanım şartları’nı dikkatlice okuyunuz. Social platformunu kullanan üyelerimiz aşağıdaki şartları kabul etmiş varsayılmaktadır: Sitemizdeki web sayfaları ve ona bağlı tüm sayfalar IEEE YTU Öğrenci Kolu'nun malıdır ve onun tarafından işletilir. Sizler (‘Kullanıcı’) sitede sunulan tüm hizmetleri kullanırken aşağıdaki şartlara tabi olduğunuzu, sitedeki hizmetten yararlanmakla ve kullanmaya devam etmekle; Bağlı olduğunuz yasalara göre sözleşme imzalama hakkına, yetkisine ve hukuki ehliyetine sahip ve 18 yaşın üzerinde olduğunuzu, bu sözleşmeyi okuduğunuzu, anladığınızı ve sözleşmede yazan şartlarla bağlı olduğunuzu kabul etmiş sayılırsınız. İşbu sözleşme taraflara sözleşme konusu site ile ilgili hak ve yükümlülükler yükler ve taraflar işbu sözleşmeyi kabul ettiklerinde bahsi geçen hak ve yükümlülükleri eksiksiz, doğru, zamanında, işbu sözleşmede talep edilen şartlar dâhilinde yerine getireceklerini beyan ederler. 1. SORUMLULUKLAR a.Kulüp, etkinlikler, duyurular vs. üzerinde değişiklik yapma hakkını her zaman saklı tutar. b.Firma, üyenin sözleşme konusu hizmetlerden, teknik arızalar dışında yararlandırılacağını kabul ve taahhüt eder. c.Kullanıcı, sitenin kullanımında tersine mühendislik yapmayacağını ya da bunların kaynak kodunu bulmak veya elde etmek amacına yönelik herhangi bir başka işlemde bulunmayacağını aksi halde ve 3. Kişiler nezdinde doğacak zararlardan sorumlu olacağını, hakkında hukuki ve cezai işlem yapılacağını peşinen kabul eder. d.Kullanıcı, site içindeki faaliyetlerinde, sitenin herhangi bir bölümünde veya iletişimlerinde genel ahlaka ve adaba aykırı, kanuna aykırı, 3. Kişilerin haklarını zedeleyen, yanıltıcı, saldırgan, müstehcen, pornografik, kişilik haklarını zedeleyen, telif haklarına aykırı, yasa dışı faaliyetleri teşvik eden içerikler üretmeyeceğini, paylaşmayacağını kabul eder. Aksi halde oluşacak zarardan tamamen kendisi sorumludur ve bu durumda ‘Site’ yetkilileri, bu tür hesapları askıya alabilir, sona erdirebilir, yasal süreç başlatma hakkını saklı tutar. Bu sebeple yargı mercilerinden etkinlik veya kullanıcı hesapları ile ilgili bilgi talepleri gelirse paylaşma hakkını saklı tutar. e.Sitenin üyelerinin birbirleri veya üçüncü şahıslarla olan ilişkileri kendi sorumluluğundadır. 2. Fikri Mülkiyet Hakları 2.1. İşbu Site’de yer alan ünvan, işletme adı, marka, patent, logo, tasarım, bilgi ve yöntem gibi tescilli veya tescilsiz tüm fikri mülkiyet hakları site işleteni ve sahibi firmaya veya belirtilen ilgilisine ait olup, ulusal ve uluslararası hukukun koruması altındadır. İşbu Site’nin ziyaret edilmesi veya bu Site’deki hizmetlerden yararlanılması söz konusu fikri mülkiyet hakları konusunda hiçbir hak vermez. 2.2. Site’de yer alan bilgiler hiçbir şekilde çoğaltılamaz, yayınlanamaz, kopyalanamaz, sunulamaz ve/veya aktarılamaz. Site’nin bütünü veya bir kısmı diğer bir internet sitesinde izinsiz olarak kullanılamaz. 3. Gizli Bilgi 3.1. Kullanıcı, sadece tanıtım, reklam, kampanya, promosyon, duyuru vb. pazarlama faaliyetleri kapsamında kullanılması ile sınırlı olmak üzere, Site’nin sahibi olan firmanın kendisine ait iletişim, portföy durumu ve demografik bilgilerini iştirakleri ya da bağlı bulunduğu grup şirketleri ile paylaşmasına muvafakat ettiğini kabul ve beyan eder. Bu kişisel bilgiler firma bünyesinde müşteri profili belirlemek, müşteri profiline uygun promosyon ve kampanyalar sunmak ve istatistiksel çalışmalar yapmak amacıyla kullanılabilecektir. 4. Garanti Vermeme: İŞBU SÖZLEŞME MADDESİ UYGULANABİLİR KANUNUN İZİN VERDİĞİ AZAMİ ÖLÇÜDE GEÇERLİ OLACAKTIR. FİRMA TARAFINDAN SUNULAN HİZMETLER "OLDUĞU GİBİ” VE "MÜMKÜN OLDUĞU” TEMELDE SUNULMAKTA VE PAZARLANABİLİRLİK, BELİRLİ BİR AMACA UYGUNLUK VEYA İHLAL ETMEME KONUSUNDA TÜM ZIMNİ GARANTİLER DE DÂHİL OLMAK ÜZERE HİZMETLER VEYA UYGULAMA İLE İLGİLİ OLARAK (BUNLARDA YER ALAN TÜM BİLGİLER DÂHİL) SARİH VEYA ZIMNİ, KANUNİ VEYA BAŞKA BİR NİTELİKTE HİÇBİR GARANTİDE BULUNMAMAKTADIR. 5. Kayıt ve Güvenlik Kullanıcı, doğru, eksiksiz ve güncel kayıt bilgilerini vermek zorundadır. Aksi halde bu Sözleşme ihlal edilmiş sayılacak ve Kullanıcı bilgilendirilmeksizin hesap kapatılabilecektir. Kullanıcı, site ve üçüncü taraf sitelerdeki şifre ve hesap güvenliğinden kendisi sorumludur. Aksi halde oluşacak veri kayıplarından ve güvenlik ihlallerinden veya donanım ve cihazların zarar görmesinden Firma sorumlu tutulamaz. 6. Mücbir Sebep Tarafların kontrolünde olmayan; tabii afetler, yangın, patlamalar, iç savaşlar, savaşlar, ayaklanmalar, halk hareketleri, seferberlik ilanı, grev, lokavt ve salgın hastalıklar, altyapı ve internet arızaları, elektrik kesintisi gibi sebeplerden (aşağıda birlikte "Mücbir Sebep” olarak anılacaktır.) dolayı sözleşmeden doğan yükümlülükler taraflarca ifa edilemez hale gelirse, taraflar bundan sorumlu değildir. Bu sürede Taraflar’ın işbu Sözleşme’den doğan hak ve yükümlülükleri askıya alınır. 7. Sözleşmenin Bütünlüğü ve Uygulanabilirlik İşbu sözleşme şartlarından biri, kısmen veya tamamen geçersiz hale gelirse, sözleşmenin geri kalanı geçerliliğini korumaya devam eder. 8. Sözleşmede Yapılacak Değişiklikler Firma, dilediği zaman sitede sunulan hizmetleri ve işbu sözleşme şartlarını kısmen veya tamamen değiştirebilir. Değişiklikler sitede yayınlandığı tarihten itibaren geçerli olacaktır. Değişiklikleri takip etmek Kullanıcı’nın sorumluluğundadır. Kullanıcı, sunulan hizmetlerden yararlanmaya devam etmekle bu değişiklikleri de kabul etmiş sayılır. 9. Tebligat İşbu Sözleşme ile ilgili taraflara gönderilecek olan tüm bildirimler, Firma’nın bilinen e.posta adresi ve kullanıcının üyelik formunda belirttiği e.posta adresi vasıtasıyla yapılacaktır. Kullanıcı, üye olurken belirttiği adresin geçerli tebligat adresi olduğunu, değişmesi durumunda 5 gün içinde yazılı olarak diğer tarafa bildireceğini, aksi halde bu adrese yapılacak tebligatların geçerli sayılacağını kabul eder. 10. Delil Sözleşmesi Taraflar arasında işbu sözleşme ile ilgili işlemler için çıkabilecek her türlü uyuşmazlıklarda Taraflar’ın defter, kayıt ve belgeleri ile ve bilgisayar kayıtları ve faks kayıtları 6100 sayılı Hukuk Muhakemeleri Kanunu uyarınca delil olarak kabul edilecek olup, kullanıcı bu kayıtlara itiraz etmeyeceğini kabul eder. 11. Uyuşmazlıkların Çözümü İşbu Sözleşme’nin uygulanmasından veya yorumlanmasından doğacak her türlü uyuşmazlığın çözümünde İstanbul (Merkez) Adliyesi Mahkemeleri ve İcra Daireleri yetkilidir.''';
