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

  final String id;
  final dynamic color;
  final int commentCount;
  final dynamic icon;
  final String photo;
  final List<String> likedBy;
  final bool isClosed;
  final String committeeId;
  final String website;
  final String name;
  final String description;
  final List<Session> sessions;
  final DateTime date;
  final DateTime eventDate;
  final String adder;
  final String slug;
  final int appCount;
  final int v;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        color: json["color"],
        commentCount: json["commentCount"],
        icon: json["icon"],
        photo: json["photo"],
        likedBy: List<String>.from(json["likedBy"].map((x) => x.toString())),
        isClosed: json["isClosed"],
        committeeId: json["committeeId"],
        website: json["website"],
        name: json["name"],
        description: json["description"],
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
        date: DateTime.parse(json["date"]),
        eventDate: DateTime.parse(json["eventDate"]),
        adder: json["adder"],
        slug: json["slug"],
        appCount: json["appCount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "color": color,
        "commentCount": commentCount,
        "icon": icon,
        "photo": photo,
        "likedBy": List<dynamic>.from(likedBy.map((x) => x.toString())),
        "isClosed": isClosed,
        "committeeId": committeeId,
        "website": website,
        "name": name,
        "description": description,
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
        "date": date,
        "eventDate": eventDate,
        "adder": adder,
        "slug": slug,
        "appCount": appCount,
        "__v": v,
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

  final String id;
  final DateTime time;
  final String title;
  final bool attendanceButton;
  final String link;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["_id"],
        time: DateTime.parse(json["time"]),
        title: json["title"],
        attendanceButton: json["attendanceButton"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "time": time,
        "title": title,
        "attendanceButton": attendanceButton,
        "link": link,
      };
}
