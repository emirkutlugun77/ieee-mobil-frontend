import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;
  const ProfileSection({
    Key? key,
    required this.title,
    required this.child,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Padding(
        padding: EdgeInsets.only(left: 58.0, right: 58, top: 40 * height / 800),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 25 * height / 900),
                  ),
                ],
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
