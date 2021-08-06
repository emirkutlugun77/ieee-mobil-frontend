import 'dart:convert';

class MinEvent {
  String photo;
  String committeeColor;
  String committeeName;
  String name;
  String id;
  MinEvent({
    required this.photo,
    required this.committeeColor,
    required this.committeeName,
    required this.name,
    required this.id,
  });

  MinEvent copyWith({
    String? photo,
    String? committeeColor,
    String? committeeName,
    String? name,
    String? id,
  }) {
    return MinEvent(
      photo: photo ?? this.photo,
      committeeColor: committeeColor ?? this.committeeColor,
      committeeName: committeeName ?? this.committeeName,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'committeeColor': committeeColor,
      'committeeName': committeeName,
      'name': name,
      'id': id,
    };
  }

  factory MinEvent.fromMap(Map<String, dynamic> map) {
    return MinEvent(
      photo: map['photo'],
      committeeColor: map['committeeId']['color'],
      committeeName: map['committeeId']['name'],
      name: map['name'],
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MinEvent.fromJson(String source) =>
      MinEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MinEvent(photo: $photo, committeeColor: $committeeColor, committeeName: $committeeName, name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MinEvent &&
        other.photo == photo &&
        other.committeeColor == committeeColor &&
        other.committeeName == committeeName &&
        other.name == name &&
        other.id == id;
  }

  @override
  int get hashCode {
    return photo.hashCode ^
        committeeColor.hashCode ^
        committeeName.hashCode ^
        name.hashCode ^
        id.hashCode;
  }
}
