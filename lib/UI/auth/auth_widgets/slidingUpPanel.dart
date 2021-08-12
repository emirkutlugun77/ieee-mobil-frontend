import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingWidget extends StatelessWidget {
  const SlidingWidget(
      {Key? key,
      required PanelController panelController,
      required this.height,
      required this.message,
      required this.backgroundColor})
      : _panelController = panelController,
        super(key: key);
  final Color backgroundColor;
  final String message;
  final PanelController _panelController;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      boxShadow: [BoxShadow(blurRadius: 0, color: Colors.transparent)],
      color: Colors.transparent,
      controller: _panelController,
      defaultPanelState: PanelState.CLOSED,
      minHeight: 0,
      maxHeight: height * 1 / 8,
      panel: Padding(
        padding: EdgeInsets.all(30.0 * height / 1000),
        child: Container(
          height: height * 1 / 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).backgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}

Widget floatingCollapsed() {
  return SizedBox();
}
