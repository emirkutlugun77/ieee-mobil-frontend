import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: LineIcon.angleLeft())
              ],
            ),
          ),
          Text(
            'Emir Kutlugün',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 32),
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          Text(
            'Yıldız Teknik Üniversitesi',
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          Text(
            'Matematik Mühendisliği',
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          QrImage(
            data: "1234567890", //user.id
            version: QrVersions.auto,
            size: height * 2 / 5,
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          Container(
            height: height * 1 / 6,
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Text(
              'Etkinliklere Girerken Bu QR kodunu Okutmanız Yeterli Olacaktır!',
              style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
