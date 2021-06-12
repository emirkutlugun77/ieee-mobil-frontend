import 'dart:convert';

EventSession eventSessionFromJson(String str) =>
    EventSession.fromJson(json.decode(str));

String eventSessionToJson(EventSession data) => json.encode(data.toJson());

class EventSession {
  EventSession({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.v,
    required this.attendedSessions,
  });

  final Id id;
  final Id eventId;
  final Id userId;
  final int v;
  final List<Id> attendedSessions;

  factory EventSession.fromJson(Map<String, dynamic> json) => EventSession(
        id: Id.fromJson(json["_id"]),
        eventId: Id.fromJson(json["eventId"]),
        userId: Id.fromJson(json["userId"]),
        v: json["__v"],
        attendedSessions:
            List<Id>.from(json["attendedSessions"].map((x) => Id.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "eventId": eventId.toJson(),
        "userId": userId.toJson(),
        "__v": v,
        "attendedSessions":
            List<dynamic>.from(attendedSessions.map((x) => x.toJson())),
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
