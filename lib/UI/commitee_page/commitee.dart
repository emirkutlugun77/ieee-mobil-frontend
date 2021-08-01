import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/user.dart';

class ComiteePage extends StatefulWidget {
  final Commitee commitee;
  final List<User> coordination;
  const ComiteePage(
      {Key? key, required this.commitee, required this.coordination})
      : super(key: key);

  @override
  _ComiteePageState createState() => _ComiteePageState();
}

class _ComiteePageState extends State<ComiteePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 58.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Hero(
                          tag: widget.commitee.photo,
                          child: Image.network(
                            widget.commitee.photo,
                          ),
                        ),
                        Positioned(
                            top: 20,
                            left: 20,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: LineIcon.arrowLeft())),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.commitee.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1 / 2,
                        height: MediaQuery.of(context).size.height * 1 / 5.5,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: widget.coordination.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.coordination[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          widget.coordination[index].name +
                                              ' ' +
                                              widget
                                                  .coordination[index].surname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Text('Hakkımızda:',
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Wrap(children: [
                Text(
                    widget.commitee.description.length >= 300
                        ? widget.commitee.description.substring(0, 300) + '...'
                        : widget.commitee.description,
                    style: Theme.of(context).textTheme.bodyText1),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          if (Platform.isIOS) {
                            return CupertinoAlertDialog(
                              title: Text('Hakkımızda'),
                              content: Text(widget.commitee.description),
                            );
                          } else {
                            return AlertDialog(
                              title: Text('Hakkımızda'),
                              content: Text(widget.commitee.description),
                            );
                          }
                        });
                  },
                  child: Text(
                      widget.commitee.description.length >= 300
                          ? 'Tamamını Oku'
                          : '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor)),
                )
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Text('Etkinlikler:',
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 58.0, top: 28),
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingleEvent(event: )));*/
                        },
                        child: Hero(
                          tag: 'event${index + 1}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'images/ev${index + 1}.jpg',
                              fit: BoxFit.fitHeight,
                              width:
                                  MediaQuery.of(context).size.width * 1 / 2.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ))
          ]),
        ));
  }
}
