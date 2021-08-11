import 'dart:convert';

class MinCommittee {
  String id;
  String photo;
  int subCount;
  String name;
  String instaUrl;

  MinCommittee({
    required this.id,
    required this.photo,
    required this.subCount,
    required this.name,
    required this.instaUrl,
  });

  MinCommittee copyWith({
    String? id,
    String? photo,
    int? subCount,
    String? name,
    String? instaUrl,
  }) {
    return MinCommittee(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      subCount: subCount ?? this.subCount,
      name: name ?? this.name,
      instaUrl: instaUrl ?? this.instaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'photo': photo,
      'subCount': subCount,
      'name': name,
      'instaUrl': instaUrl,
    };
  }

  factory MinCommittee.fromMap(Map<String, dynamic> map) {
    return MinCommittee(
      id: map['_id'],
      photo: map['photo'],
      subCount: map['subscriptionCount'],
      name: map['name'],
      instaUrl: map['instaUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MinCommittee.fromJson(String source) =>
      MinCommittee.fromMap(json.decode(source));
}
