import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.id,
    required this.likedBy,
    required this.text,
    required this.userId,
    required this.eventId,
    required this.date,
    required this.v,
  });

  final Id id;
  final List<Id> likedBy;
  final String text;
  final Id userId;
  final Id eventId;
  final Date date;
  final int v;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: Id.fromJson(json["_id"]),
        likedBy: List<Id>.from(json["likedBy"].map((x) => Id.fromJson(x))),
        text: json["text"],
        userId: Id.fromJson(json["userId"]),
        eventId: Id.fromJson(json["eventId"]),
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "likedBy": List<dynamic>.from(likedBy.map((x) => x.toJson())),
        "text": text,
        "userId": userId.toJson(),
        "eventId": eventId.toJson(),
        "date": date.toJson(),
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
