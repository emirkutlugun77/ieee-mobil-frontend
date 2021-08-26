import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {required this.id,
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
      required this.education,
      required this.date,
      required this.v,
      required this.photoSm,
      required this.photoXs,
      required this.blockedUsers});
  List<dynamic> blockedUsers;
  final String id;
  final bool isVerified;
  final String bio;
  final dynamic photo;
  final dynamic phoneNo;
  final String committeeId;
  final String title;
  final int role;
  final String name;
  final String surname;
  final String username;

  final Education education;
  final DateTime date;

  final int v;
  final String photoSm;
  final String photoXs;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        isVerified: json["isVerified"],
        bio: json["bio"],
        photo: json["photo"] == null ? '' : json["photo"],
        phoneNo: json["phoneNo"] == null ? '' : json['phoneNo'],
        committeeId: json['committeeId'] != null ? json['committeeId'] : '',
        title: json["title"] != null ? json["title"] : 'Üye',
        role: json["role"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        education: Education.fromJson(json["education"]),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
        photoSm: json["photoSm"] == null ? '' : json["photoSm"],
        photoXs: json["photoXs"] == null ? '' : json['photoXs'],
        blockedUsers: json['blockedUsers'] != null ? json['blockedUsers'] : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isVerified": isVerified,
        "bio": bio,
        "photo": photo,
        "phoneNo": phoneNo,
        "committeeId": committeeId,
        "title": title,
        "role": role,
        "name": name,
        "surname": surname,
        "username": username,
        "education": education.toJson(),
        "date": date,
        "__v": v,
        "photoSm": photoSm,
        "photoXs": photoXs,
      };
}

class Education {
  Education({
    required this.university,
    required this.department,
    required this.year,
  });

  late final String university;
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
