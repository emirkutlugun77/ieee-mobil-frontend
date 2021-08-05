import 'dart:convert';

import 'package:flutter/foundation.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post(
      {required this.liked,
      required this.id,
      required this.userId,
      required this.text,
      required this.photo,
      required this.date,
      required this.v,
      required this.likeCount});

  final String id;
  late final bool liked;
  final UserModelForPost userId;
  final String text;
  final String photo;
  final DateTime date;
  final int v;
  final int likeCount;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        liked: json["liked"],
        userId: UserModelForPost(
            photo: json["userId"]['photoXs'] != null
                ? json["userId"]['photoXs']
                : '',
            id: json["userId"]['_id'],
            name: json["userId"]['name'],
            surname: json["userId"]['surname'],
            username: json["userId"]['username']),
        text: json["text"],
        photo: json["photo"] != null ? json['photo'] : '',
        date: DateTime.parse((json["date"])),
        v: json["__v"],
        likeCount: json['likeCount'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "text": text,
        "photo": photo,
        "date": date,
        "__v": v,
        "liked": liked,
      };
}

class UserModelForPost {
  String photo;
  String id;
  String name;
  String surname;
  String username;
  UserModelForPost({
    required this.photo,
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
  });

  UserModelForPost copyWith({
    String? photo,
    String? id,
    String? name,
    String? surname,
    String? username,
  }) {
    return UserModelForPost(
      photo: photo ?? this.photo,
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
    };
  }

  factory UserModelForPost.fromMap(Map<String, dynamic> map) {
    return UserModelForPost(
      photo: map['photo'],
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelForPost.fromJson(String source) =>
      UserModelForPost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModelForPost(photo: $photo, id: $id, name: $name, surname: $surname, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModelForPost &&
        other.photo == photo &&
        other.id == id &&
        other.name == name &&
        other.surname == surname &&
        other.username == username;
  }

  @override
  int get hashCode {
    return photo.hashCode ^
        id.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        username.hashCode;
  }
}
