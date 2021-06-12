import 'dart:convert';

Subscription subscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

String subscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
  Subscription({
    required this.id,
    required this.userId,
    required this.committeeId,
    required this.date,
    required this.v,
  });

  final Id id;
  final Id userId;
  final Id committeeId;
  final Date date;
  final int v;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: Id.fromJson(json["_id"]),
        userId: Id.fromJson(json["userId"]),
        committeeId: Id.fromJson(json["committeeId"]),
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "userId": userId.toJson(),
        "committeeId": committeeId.toJson(),
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
