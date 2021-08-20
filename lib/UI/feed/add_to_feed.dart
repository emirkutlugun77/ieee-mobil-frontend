import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';

import 'package:my_app/Functions/post_functions.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

XFile? imageFile;
String text = '';

// ignore: must_be_immutable
class AddToFeed extends StatefulWidget {
  AddToFeed({required this.postList, required this.socket});
  List<Post> postList;
  IO.Socket socket;
  @override
  _AddToFeedState createState() => _AddToFeedState();
}

class _AddToFeedState extends State<AddToFeed> {
  initState() {
    super.initState();
    imageFile = null;
  }

  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(FontAwesomeIcons.chevronRight, color: Colors.white),
        onPressed: () async {
          var prefs = await SharedPreferences.getInstance();
          String token = (prefs.getString('token'))!;

          await writePost(
                  imageFile != null ? File(imageFile!.path) : null, text, token)
              .then((value) {
            Post newPost = new Post(
              date: DateTime.parse(value['date']),
              id: value['_id'],
              likeCount: 0,
              liked: false,
              photo: value["photo"] != null ? value['photo'] : '',
              text: value['text'],
              userId: UserModelForPost(
                id: value['userId']['_id'],
                photo: value['userId']['photoXs'] != null
                    ? value['userId']['photoXs']
                    : '',
                name: value['userId']['name'],
                surname: value['userId']['surname'],
                username: value['userId']['username'],
              ),
              v: value['__v'],
            );
            setState(() {
              widget.socket.emit('post-created', newPost);
            });

            Navigator.pop(context, widget.postList);
          });
        },
      ),
      body: Container(
        color: Color(0xFFF8FAFF),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 58.0 * height / 1000,
                      left: 28.0 * height / 1000,
                      right: 58.0 * height / 1000),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: LineIcon.angleLeft()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Text(
                        'Yorum Ekle',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 48.0 * height / 1000, bottom: 8.0 * height / 1000),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.9,
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 18.0),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(180),
                                  ],
                                  onChanged: (value) => text = value,
                                  maxLines: 5,
                                  style: TextStyle(fontSize: 17 * height / 700),
                                  textAlignVertical: TextAlignVertical.center,
                                ),
                              ),
                            )),
                        Positioned(
                            left: 30 * height / 1000,
                            child: Text(
                              'Yazı',
                              style: Theme.of(context).textTheme.headline1!,
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 30 * height / 1000,
                          child: Text(
                            'Resim',
                            style: Theme.of(context).textTheme.headline1!,
                          )),
                      Padding(
                        padding: EdgeInsets.all(height / 105 * 00),
                        child: Center(
                          child: imageFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                      File(
                                        imageFile!.path,
                                      ),
                                      height: height / 3))
                              : GestureDetector(
                                  onTap: () {
                                    _panelController.open();
                                  },
                                  child: Icon(Icons.add,
                                      size: height / 4,
                                      color: Theme.of(context).primaryColor),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
