import 'dart:convert';

Application applicationFromJson(String str) =>
    Application.fromJson(json.decode(str));

String applicationToJson(Application data) => json.encode(data.toJson());

class Application {
  Application({
    required this.id,
    required this.isAccepted,
    required this.isSuccessful,
    required this.eventId,
    required this.userId,
    required this.formId,
    required this.answers,
    required this.date,
    required this.v,
  });

  final Id id;
  final bool isAccepted;
  final bool isSuccessful;
  final Id eventId;
  final Id userId;
  final Id formId;
  final List<Answer> answers;
  final Date date;
  final int v;

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: Id.fromJson(json["_id"]),
        isAccepted: json["isAccepted"],
        isSuccessful: json["isSuccessful"],
        eventId: Id.fromJson(json["eventId"]),
        userId: Id.fromJson(json["userId"]),
        formId: Id.fromJson(json["formId"]),
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        date: Date.fromJson(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "isAccepted": isAccepted,
        "isSuccessful": isSuccessful,
        "eventId": eventId.toJson(),
        "userId": userId.toJson(),
        "formId": formId.toJson(),
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "date": date.toJson(),
        "__v": v,
      };
}

class Answer {
  Answer({
    required this.questionId,
    required this.answer,
  });

  final Id questionId;
  final String answer;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: Id.fromJson(json["questionId"]),
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId.toJson(),
        "answer": answer,
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
