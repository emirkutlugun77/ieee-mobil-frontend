import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class QrCode extends StatelessWidget {
  User user;
  QrCode({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).backgroundColor,
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
            user.name + ' ' + user.surname,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 32),
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          Text(
            user.education.university,
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          Text(
            user.education.department,
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: height * 1 / 40,
          ),
          QrImage(
            data: user.id, //user.id
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
