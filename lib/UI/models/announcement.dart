import 'dart:convert';

Announcement announcementFromJson(String str) =>
    Announcement.fromJson(json.decode(str));

String announcementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  Announcement({
    required this.id,
    required this.title,
    required this.committeeId,
    required this.text,
    required this.date,
    required this.v,
  });

  final Id id;
  final String title;
  final Id committeeId;
  final String text;
  final Date date;
  final int v;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: Id.fromJson(json["_id"]),
        title: json["title"],
        committeeId: Id.fromJson(json["committeeId"]),
        text: json["text"],
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "title": title,
        "committeeId": committeeId.toJson(),
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
