import 'package:flutter/material.dart';
import 'package:my_app/constants.dart' as constants;

class CustomChip extends StatelessWidget {
  final String tag;
  const CustomChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: constants.blogCategoryColors[tag] != null
                  ? constants.blogCategoryColors[tag]!
                  : Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding:
              EdgeInsets.all(6.00 * MediaQuery.of(context).size.height / 800),
          child: Text(
            tag,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: constants.blogCategoryColors[tag]!),
          ),
        ),
      ),
    );
  }
}
