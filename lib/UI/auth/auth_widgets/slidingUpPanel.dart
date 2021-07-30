import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingWidget extends StatelessWidget {
  const SlidingWidget(
      {Key? key,
      required PanelController panelController,
      required this.height,
      required this.errorMessage})
      : _panelController = panelController,
        super(key: key);
  final String errorMessage;
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
        padding: const EdgeInsets.all(28.0),
        child: Container(
          height: height * 1 / 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).errorColor,
          ),
          child: Center(
            child: Text(
              errorMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
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

Widget floatingPanel(String error) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]),
    margin: const EdgeInsets.all(24.0),
    child: Center(
      child: Text(error),
    ),
  );
}
