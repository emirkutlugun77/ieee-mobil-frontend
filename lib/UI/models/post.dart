import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.id,
    required this.likedBy,
    required this.userId,
    required this.text,
    required this.photo,
    required this.date,
    required this.v,
  });

  final Id id;
  final List<Id> likedBy;
  final Id userId;
  final String text;
  final String photo;
  final Date date;
  final int v;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: Id.fromJson(json["_id"]),
        likedBy: List<Id>.from(json["likedBy"].map((x) => Id.fromJson(x))),
        userId: Id.fromJson(json["userId"]),
        text: json["text"],
        photo: json["photo"],
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "likedBy": List<dynamic>.from(likedBy.map((x) => x.toJson())),
        "userId": userId.toJson(),
        "text": text,
        "photo": photo,
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
