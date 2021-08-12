import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlTry extends StatelessWidget {
  const HtmlTry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data:
            '<b>IEEEXtreme</b>, IEEE öğrenci üyelerinin 24 saatlik bir zaman diliminde bir dizi programlama sorusu çözdüğü küresel bir çevrimiçi yarışmadır. Dünyadaki bütün öğrencileri bir araya getirerek onlara sıradışı zorluklarla karşılaştıran bir algoritma ve kodlama yarışmasıdır. Yarışmaya katılmak için herhangi bir yazılım dilini bilmeniz yeterlidir. Yarışma, 19 Ekim 2019 03.00’da (Cumayı cumartesiye bağlayan gece) Elektrik-Elektronik Fakültesinde başlayacaktır. Yarışmaya katılacaklar için WhatsApp grup linki: https://chat.whatsapp.com/GtdyiVqXqzuD5xNDbi8CCq',
      ),
    );
  }
}
