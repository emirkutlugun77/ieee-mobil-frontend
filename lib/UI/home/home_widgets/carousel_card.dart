import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class ComiteeCard extends StatelessWidget {
  final String imageId;
  final String comiteeName;
  final int index;
  const ComiteeCard({
    Key? key,
    required this.imageId,
    required this.comiteeName,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: 'commiteePic${index}',
              child: Container(
                margin: EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                width: width * 3 / 5,
                height: height * 2 / 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    imageId,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              comiteeName,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 25 * width / 450),
            ),
          ],
        )
      ],
    );
  }
}
