import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    required this.id,
    required this.color,
    required this.commentCount,
    required this.icon,
    required this.photo,
    required this.likedBy,
    required this.isClosed,
    required this.committeeId,
    required this.website,
    required this.name,
    required this.description,
    required this.sessions,
    required this.date,
    required this.eventDate,
    required this.adder,
    required this.slug,
    required this.appCount,
    required this.v,
  });

  final Id id;
  final dynamic color;
  final int commentCount;
  final dynamic icon;
  final String photo;
  final List<Id> likedBy;
  final bool isClosed;
  final Id committeeId;
  final String website;
  final String name;
  final String description;
  final List<Session> sessions;
  final Date date;
  final Date eventDate;
  final Id adder;
  final String slug;
  final int appCount;
  final int v;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: Id.fromJson(json["_id"]),
        color: json["color"],
        commentCount: json["commentCount"],
        icon: json["icon"],
        photo: json["photo"],
        likedBy: List<Id>.from(json["likedBy"].map((x) => Id.fromJson(x))),
        isClosed: json["isClosed"],
        committeeId: Id.fromJson(json["committeeId"]),
        website: json["website"],
        name: json["name"],
        description: json["description"],
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
        date: Date.fromJson(json["date"]),
        eventDate: Date.fromJson(json["eventDate"]),
        adder: Id.fromJson(json["adder"]),
        slug: json["slug"],
        appCount: json["appCount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "color": color,
        "commentCount": commentCount,
        "icon": icon,
        "photo": photo,
        "likedBy": List<dynamic>.from(likedBy.map((x) => x.toJson())),
        "isClosed": isClosed,
        "committeeId": committeeId.toJson(),
        "website": website,
        "name": name,
        "description": description,
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
        "date": date.toJson(),
        "eventDate": eventDate.toJson(),
        "adder": adder.toJson(),
        "slug": slug,
        "appCount": appCount,
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

class Session {
  Session({
    required this.id,
    required this.time,
    required this.title,
    required this.attendanceButton,
    required this.link,
  });

  final Id id;
  final Date time;
  final String title;
  final bool attendanceButton;
  final String link;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: Id.fromJson(json["_id"]),
        time: Date.fromJson(json["time"]),
        title: json["title"],
        attendanceButton: json["attendanceButton"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "time": time.toJson(),
        "title": title,
        "attendanceButton": attendanceButton,
        "link": link,
      };
}
