import 'dart:convert';

Announcement announcementFromJson(String str) =>
    Announcement.fromJson(json.decode(str));

String announcementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  Announcement({
    required this.id,
    required this.title,
    required this.committeeName,
    required this.text,
    required this.date,
    required this.v,
  });

  final String id;
  final String title;
  final String committeeName;
  final String text;
  final DateTime date;
  final int v;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["_id"],
        title: json["title"],
        committeeName: json["committeeId"]['name'],
        text: json["text"],
        date: DateTime.parse((json["date"])),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "committeeId": committeeName,
        "text": text,
        "date": date,
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
