import 'dart:convert';

BlogPost blogPostFromJson(String str) => BlogPost.fromJson(json.decode(str));

String blogPostToJson(BlogPost data) => json.encode(data.toJson());

class BlogPost {
  BlogPost({
    required this.id,
    required this.blogCategoryId,
    required this.likedBy,
    required this.tags,
    required this.userId,
    required this.text,
    required this.title,
    required this.photo,
    required this.slug,
    required this.viewCount,
    required this.date,
    required this.v,
  });

  final Id id;
  final List<Id> blogCategoryId;
  final List<Id> likedBy;
  final List<String> tags;
  final Id userId;
  final String text;
  final String title;
  final String photo;
  final String slug;
  final int viewCount;
  final Date date;
  final int v;

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
        id: Id.fromJson(json["_id"]),
        blogCategoryId:
            List<Id>.from(json["blogCategoryId"].map((x) => Id.fromJson(x))),
        likedBy: List<Id>.from(json["likedBy"].map((x) => Id.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
        userId: Id.fromJson(json["userId"]),
        text: json["text"],
        title: json["title"],
        photo: json["photo"],
        slug: json["slug"],
        viewCount: json["viewCount"],
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "blogCategoryId":
            List<dynamic>.from(blogCategoryId.map((x) => x.toJson())),
        "likedBy": List<dynamic>.from(likedBy.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "userId": userId.toJson(),
        "text": text,
        "title": title,
        "photo": photo,
        "slug": slug,
        "viewCount": viewCount,
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
