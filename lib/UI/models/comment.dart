import 'dart:convert';

import 'package:my_app/UI/models/post.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.id,
    required this.text,
    required this.userId,
    required this.eventId,
    required this.date,
    required this.v,
  });

  final String id;

  final String text;
  final UserModelForPost userId;
  final String eventId;
  final DateTime date;
  final int v;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        text: json["text"],
        userId: UserModelForPost(
            photo: json["userId"]['photoXs'] != null
                ? json["userId"]['photoXs']
                : '',
            id: json["userId"]['_id'],
            name: json["userId"]['name'],
            surname: json["userId"]['surname'],
            username: json["userId"]['username']),
        eventId: json["eventId"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "userId": userId.toJson(),
        "eventId": eventId,
        "date": date,
        "__v": v,
      };
}

class Date {
  Date({
    required this.date,
  });

  final DateTime date;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateTime.parse(json["\u0024date"]),
      );

  Map<String, dynamic> toJson() => {
        "\u0024date": date.toIso8601String(),
      };
}

class Id {
  Id({
    required this.oid,
  });

  final String oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}
