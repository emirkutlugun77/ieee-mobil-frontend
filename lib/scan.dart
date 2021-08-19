import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/UI/auth/auth_widgets/slidingUpPanel.dart';
import 'package:scan/scan.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Functions/readqr.dart';

// ignore: must_be_immutable
class ScanViewPage extends StatefulWidget {
  String eventId;
  String sessionId;
  ScanViewPage({
    Key? key,
    required this.eventId,
    required this.sessionId,
  }) : super(key: key);
  @override
  _ScanViewPageState createState() => _ScanViewPageState();
}

class _ScanViewPageState extends State<ScanViewPage> {
  ScanController controller = ScanController();

  PanelController _panelController = PanelController();
  String message = '';
  Color color = Color(0xFF57B665);
  bool toggled = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ScanView(
            controller: controller,
// custom scan area, if set to 1.0, will scan full area
            scanAreaScale: 1.0,
            scanLineColor: Colors.green.shade400,
            onCapture: (data) async {
              await readQr(widget.eventId, widget.sessionId, data)
                  .then((value) {
                setState(() {
                  message = value.toString();
                  if (message ==
                      'User is already attended to this event session') {
                    color = Color(0xFFFFCD52);
                  } else {
                    color = Color(0xFF57B665);
                  }
                });
              }).then((value) => _panelController.open());

              controller.resume();

              await Future.delayed(Duration(seconds: 1));
              _panelController.close();
            },
          ),
          GestureDetector(
            onTap: () {
              controller.toggleTorchMode();
              setState(() {
                toggled = !toggled;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(
                  38.0 * MediaQuery.of(context).size.height / 1000),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  Icon(
                    toggled
                        ? FontAwesomeIcons.solidLightbulb
                        : FontAwesomeIcons.lightbulb,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
          SlidingWidget(
            panelController: _panelController,
            height: MediaQuery.of(context).size.height,
            message: message,
            backgroundColor: color,
          )
        ],
      ),
    );
  }
}
