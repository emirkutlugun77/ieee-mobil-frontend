import 'dart:convert';

Commitee commiteeFromJson(String str) => Commitee.fromJson(json.decode(str));

String commiteeToJson(Commitee data) => json.encode(data.toJson());

class Commitee {
  Commitee({
    required this.id,
    required this.subscriptionCount,
    required this.photo,
    required this.instaUrl,
    required this.color,
    required this.icon,
    required this.name,
    required this.description,
    required this.date,
    required this.v,
  });

  final String id;
  final int subscriptionCount;
  final String photo;

  final String instaUrl;
  final String color;
  final dynamic icon;
  final String name;
  final String description;
  final DateTime date;
  final int v;

  factory Commitee.fromJson(Map<String, dynamic> json) => Commitee(
        id: json["_id"],
        subscriptionCount: json["subscriptionCount"],
        photo: json["photo"],
        instaUrl: json["instaUrl"] == null ? '' : json["instaUrl"],
        color: json["color"],
        icon: json["icon"] == null ? '' : json['icon'],
        name: json["name"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subscriptionCount": subscriptionCount,
        "photo": photo,
        "instaUrl": instaUrl,
        "color": color,
        "icon": icon,
        "name": name,
        "description": description,
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
