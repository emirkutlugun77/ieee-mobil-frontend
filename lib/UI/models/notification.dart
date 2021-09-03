import 'dart:convert';

import 'package:flutter/foundation.dart';

class Notification {
  DateTime date;
  DateTime expireDate;
  List<dynamic> seenBy;
  String id;
  String title;
  String coverImage;
  String actionType;
  String context;
  Notification({
    required this.date,
    required this.expireDate,
    required this.seenBy,
    required this.id,
    required this.title,
    required this.coverImage,
    required this.actionType,
    required this.context,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'expireDate': expireDate.millisecondsSinceEpoch,
      'seenBy': seenBy,
      '_id': id,
      'title': title,
      'coverImage': coverImage,
      'actionType': actionType,
      'context': context,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      expireDate: DateTime.fromMillisecondsSinceEpoch(map['expireDate']),
      seenBy: List<dynamic>.from(map['seenBy']),
      id: map['_id'],
      title: map['title'],
      coverImage: map['coverImage'],
      actionType: map['actionType'],
      context: map['context'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(date: $date, expireDate: $expireDate, seenBy: $seenBy, _id: $id, title: $title, coverImage: $coverImage, actionType: $actionType, context: $context)';
  }
}
