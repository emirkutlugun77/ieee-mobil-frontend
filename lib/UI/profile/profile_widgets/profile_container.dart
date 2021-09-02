import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:my_app/UI/models/user.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class ProfileContainer extends StatefulWidget {
  ProfileContainer(
      {Key? key,
      required this.pageController,
      required this.user,
      required this.width,
      required this.height,
      required this.blogCount,
      required this.committeCount,
      required this.eventCount,
      required this.containerInt,
      required this.panelController})
      : super(key: key);
  final PanelController panelController;
  int containerInt;
  final PageController pageController;
  final int blogCount;
  final int committeCount;
  final int eventCount;
  final User user;
  final double width;
  final double height;

  @override
  _ProfileContainerState createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 3 / 4,
      height: widget.height * 1.9 / 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
      child: Stack(
        children: [
          Container(
            width: widget.width * 3 / 4,
            height: widget.height * 1.7 / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).backgroundColor),
            child: Padding(
              padding: EdgeInsets.all(8.0 * widget.height / 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.height * 1 / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.panelController.open();
                          },
                          child: Container(
                            width: widget.width * 1 / 5,
                            height: widget.width * 1 / 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: widget.user.photoXs != ''
                                    ? widget.user.photoXs
                                    : 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.name + ' ' + widget.user.surname,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 16),
                              ),
                              SizedBox(
                                height: widget.height * 1 / 120,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  widget.user.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            18.0 * MediaQuery.of(context).size.height / 1000,
                        vertical: 3 * widget.height / 700),
                    child: Text('Okul',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14 * widget.height / 700,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      width: widget.width * 5 / 6,
                      child: Text(
                        widget.user.education.university,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize:
                                widget.user.education.university.length > 35
                                    ? 11 * widget.height / 700
                                    : 13 * widget.height / 700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            18.0 * MediaQuery.of(context).size.height / 1000,
                        vertical:
                            6 * MediaQuery.of(context).size.height / 1000),
                    child: Text('Bölüm',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14 * widget.height / 700,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      width: widget.width * 5 / 6,
                      child: Text(
                        widget.user.education.department,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize:
                                widget.user.education.department.length > 30
                                    ? 9 * widget.height / 700
                                    : 14 * widget.height / 700),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: widget.width * 1 / 1.6,
              height: widget.width * 1 / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.containerInt = 0;
                      });
                      widget.pageController.animateToPage(0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.containerInt == 0
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.eventCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Etkinlik',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.containerInt = 1;
                      });
                      widget.pageController.animateToPage(1,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.containerInt == 1
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.committeCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Komite',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.containerInt = 2;
                      });
                      widget.pageController.animateToPage(2,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.containerInt == 2
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.blogCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Sertifika',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.containerInt = 3;
                      });
                      widget.pageController.animateToPage(3,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.containerInt == 3
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.blogCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Pano',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
