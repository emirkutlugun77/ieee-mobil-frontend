import 'dart:convert';

class NotificationModel {
  DateTime date;
  DateTime expireDate;

  String id;
  String title;
  String coverImage;
  String actionType;
  String context;
  NotificationModel({
    required this.date,
    required this.expireDate,
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
      '_id': id,
      'title': title,
      'coverImage': coverImage,
      'actionType': actionType,
      'context': context,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        date: DateTime.parse(json['date']),
        expireDate: DateTime.parse(json['expireDate']),
        id: json['_id'],
        title: json['title'],
        coverImage: json['coverImage'],
        actionType: json['actionType'],
        context: json['context'],
      );

  @override
  String toString() {
    return 'Notification(date: $date, expireDate: $expireDate, _id: $id, title: $title, coverImage: $coverImage, actionType: $actionType, context: $context)';
  }
}
