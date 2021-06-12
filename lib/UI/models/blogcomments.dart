import 'dart:convert';

BlogComments blogCommentsFromJson(String str) =>
    BlogComments.fromJson(json.decode(str));

String blogCommentsToJson(BlogComments data) => json.encode(data.toJson());

class BlogComments {
  BlogComments({
    required this.id,
    required this.likedBy,
    required this.parentId,
    required this.userId,
    required this.blogPostId,
    required this.text,
    required this.date,
    required this.v,
  });

  final Id id;
  final List<dynamic> likedBy;
  final dynamic parentId;
  final Id userId;
  final Id blogPostId;
  final String text;
  final Date date;
  final int v;

  factory BlogComments.fromJson(Map<String, dynamic> json) => BlogComments(
        id: Id.fromJson(json["_id"]),
        likedBy: List<dynamic>.from(json["likedBy"].map((x) => x)),
        parentId: json["parentId"],
        userId: Id.fromJson(json["userId"]),
        blogPostId: Id.fromJson(json["blogPostId"]),
        text: json["text"],
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "likedBy": List<dynamic>.from(likedBy.map((x) => x)),
        "parentId": parentId,
        "userId": userId.toJson(),
        "blogPostId": blogPostId.toJson(),
        "text": text,
        "date": date.toJson(),
        "__v": v,
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
