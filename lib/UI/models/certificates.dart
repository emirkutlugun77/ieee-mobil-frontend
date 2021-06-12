import 'dart:convert';

Certificate certificateFromJson(String str) =>
    Certificate.fromJson(json.decode(str));

String certificateToJson(Certificate data) => json.encode(data.toJson());

class Certificate {
  Certificate({
    required this.id,
    required this.eventId,
    required this.x,
    required this.y,
    required this.googleFontUrl,
    required this.fontSize,
    required this.photo,
    required this.rules,
  });

  final Id id;
  final Id eventId;
  final int x;
  final int y;
  final String googleFontUrl;
  final int fontSize;
  final String photo;
  final List<Rule> rules;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: Id.fromJson(json["_id"]),
        eventId: Id.fromJson(json["eventId"]),
        x: json["x"],
        y: json["y"],
        googleFontUrl: json["googleFontUrl"],
        fontSize: json["fontSize"],
        photo: json["photo"],
        rules: List<Rule>.from(json["rules"].map((x) => Rule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "eventId": eventId.toJson(),
        "x": x,
        "y": y,
        "googleFontUrl": googleFontUrl,
        "fontSize": fontSize,
        "photo": photo,
        "rules": List<dynamic>.from(rules.map((x) => x.toJson())),
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

class Rule {
  Rule({
    required this.sessionIds,
    required this.minimumCount,
    required this.type,
  });

  final List<Id> sessionIds;
  final int minimumCount;
  final String type;

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
        sessionIds:
            List<Id>.from(json["sessionIds"].map((x) => Id.fromJson(x))),
        minimumCount: json["minimumCount"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "sessionIds": List<dynamic>.from(sessionIds.map((x) => x.toJson())),
        "minimumCount": minimumCount,
        "type": type,
      };
}
