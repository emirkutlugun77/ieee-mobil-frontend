import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import 'package:my_app/Functions/committee.dart';
import 'package:my_app/UI/event/single_event.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/user.dart';

// ignore: must_be_immutable
class ComiteePage extends StatefulWidget {
  final Commitee commitee;
  User user;
  ComiteePage({
    Key? key,
    required this.commitee,
    required this.user,
  }) : super(key: key);

  @override
  _ComiteePageState createState() => _ComiteePageState();
}

class _ComiteePageState extends State<ComiteePage> {
  Future<List<dynamic>> getCoordinationTeamInit(String id) async {
    var userList = await getCoordinationTeam(id);
    return Future.value(userList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
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
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0 *
                                          MediaQuery.of(context).size.height /
                                          1000),
                                      child: LineIcon.arrowLeft(),
                                    )))),
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
                      FutureBuilder<List<dynamic>>(
                          future: getCoordinationTeamInit(widget.commitee.id),
                          builder: (context, snapshot) {
                            print(snapshot);
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Container(
                                width:
                                    MediaQuery.of(context).size.width * 1 / 2,
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    5.5,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                  snapshot.data![index].name +
                                                      ' ' +
                                                      snapshot
                                                          .data![index].surname,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1)
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }
                          })
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
                        ? widget.commitee.description.substring(0, 150) + '...'
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
              height: MediaQuery.of(context).size.height * 1 / 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 28.0 * MediaQuery.of(context).size.height / 1000,
                  vertical: MediaQuery.of(context).size.width / 20),
              child: Row(
                children: [
                  Text('Etkinlikler:',
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(
                top: 8 * MediaQuery.of(context).size.height / 1000,
                bottom: 18.0 * MediaQuery.of(context).size.height / 1000,
              ),
              child: FutureBuilder<List<Event>>(
                  future: getCommitteeEvents(widget.commitee.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SingleEvent(
                                                event: snapshot.data![index],
                                                user: widget.user,
                                              )));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      4,
                                  child: Hero(
                                    tag: snapshot.data![index].photo,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data![index].photo,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ))
          ]),
        ));
  }
}
