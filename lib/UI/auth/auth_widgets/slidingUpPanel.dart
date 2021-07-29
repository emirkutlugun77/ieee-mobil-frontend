import 'package:flutter/material.dart';

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
