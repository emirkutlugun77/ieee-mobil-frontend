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

  final String id;
  final List<String> likedBy;
  final String userId;
  final String text;
  final String photo;
  final DateTime date;
  final int v;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        likedBy: List<String>.from(json["likedBy"].map((x) => x.toString())),
        userId: json["userId"],
        text: json["text"],
        photo: json["photo"],
        date: DateTime.parse((json["date"])),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "likedBy": List<dynamic>.from(likedBy.map((x) => x.toString())),
        "userId": userId,
        "text": text,
        "photo": photo,
        "date": date,
        "__v": v,
      };
}
