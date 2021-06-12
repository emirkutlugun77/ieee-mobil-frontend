import 'dart:convert';

Form formFromJson(String str) => Form.fromJson(json.decode(str));

String formToJson(Form data) => json.encode(data.toJson());

class Form {
  Form({
    required this.id,
    required this.eventId,
    required this.questions,
    required this.date,
    required this.v,
  });

  final Id id;
  final Id eventId;
  final List<Question> questions;
  final Date date;
  final int v;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        id: Id.fromJson(json["_id"]),
        eventId: Id.fromJson(json["eventId"]),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "eventId": eventId.toJson(),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "date": date.toJson(),
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

class Question {
  Question({
    required this.option,
    required this.id,
    required this.title,
    required this.type,
    required this.detail,
  });

  final List<dynamic> option;
  final Id id;
  final String title;
  final String type;
  final String detail;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        option: List<dynamic>.from(json["option"].map((x) => x)),
        id: Id.fromJson(json["_id"]),
        title: json["title"],
        type: json["type"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "option": List<dynamic>.from(option.map((x) => x)),
        "_id": id.toJson(),
        "title": title,
        "type": type,
        "detail": detail,
      };
}
