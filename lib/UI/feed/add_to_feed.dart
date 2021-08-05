import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class AddToFeed extends StatelessWidget {
  const AddToFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xFFF8FAFF),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 58.0 * height / 1000,
                left: 28.0 * height / 1000,
                right: 58.0 * height / 1000),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: LineIcon.angleLeft()),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Text(
                  'Yorum Ekle',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
