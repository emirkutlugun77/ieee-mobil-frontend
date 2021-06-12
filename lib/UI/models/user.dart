import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.isVerified,
    required this.bio,
    required this.photo,
    required this.phoneNo,
    required this.committeeId,
    required this.title,
    required this.role,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.education,
    required this.date,
    required this.password,
    required this.v,
    required this.photoSm,
    required this.photoXs,
    required this.oldCommittees,
  });

  final Id id;
  final bool isVerified;
  final String bio;
  final dynamic photo;
  final dynamic phoneNo;
  final Id committeeId;
  final String title;
  final int role;
  final String name;
  final String surname;
  final String username;
  final String email;
  final Education education;
  final Date date;
  final String password;
  final int v;
  final String photoSm;
  final String photoXs;
  final List<dynamic> oldCommittees;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: Id.fromJson(json["_id"]),
        isVerified: json["isVerified"],
        bio: json["bio"],
        photo: json["photo"],
        phoneNo: json["phoneNo"],
        committeeId: Id.fromJson(json["committeeId"]),
        title: json["title"],
        role: json["role"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        email: json["email"],
        education: Education.fromJson(json["education"]),
        date: Date.fromJson(json["date"]),
        password: json["password"],
        v: json["__v"],
        photoSm: json["photoSm"],
        photoXs: json["photoXs"],
        oldCommittees: List<dynamic>.from(json["oldCommittees"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "isVerified": isVerified,
        "bio": bio,
        "photo": photo,
        "phoneNo": phoneNo,
        "committeeId": committeeId.toJson(),
        "title": title,
        "role": role,
        "name": name,
        "surname": surname,
        "username": username,
        "email": email,
        "education": education.toJson(),
        "date": date.toJson(),
        "password": password,
        "__v": v,
        "photoSm": photoSm,
        "photoXs": photoXs,
        "oldCommittees": List<dynamic>.from(oldCommittees.map((x) => x)),
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

class Education {
  Education({
    required this.university,
    required this.department,
    required this.year,
  });

  final String university;
  final String department;
  final int year;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        university: json["university"],
        department: json["department"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "university": university,
        "department": department,
        "year": year,
      };
}
