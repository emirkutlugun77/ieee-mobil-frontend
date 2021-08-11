import 'dart:convert';

class MinCertificate {
  String id;
  int x;
  int y;
  String fontUrl;
  int fontSize;
  String photo;
  MinCertificate({
    required this.id,
    required this.x,
    required this.y,
    required this.fontUrl,
    required this.fontSize,
    required this.photo,
  });

  MinCertificate copyWith({
    String? id,
    int? x,
    int? y,
    String? fontUrl,
    int? fontSize,
    String? photo,
  }) {
    return MinCertificate(
      id: id ?? this.id,
      x: x ?? this.x,
      y: y ?? this.y,
      fontUrl: fontUrl ?? this.fontUrl,
      fontSize: fontSize ?? this.fontSize,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'x': x,
      'y': y,
      'fontUrl': fontUrl,
      'fontSize': fontSize,
      'photo': photo,
    };
  }

  factory MinCertificate.fromMap(Map<String, dynamic> map) {
    return MinCertificate(
      id: map['_id'],
      x: map['x'],
      y: map['y'],
      fontUrl: map['fontUrl'],
      fontSize: map['fontSize'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MinCertificate.fromJson(String source) =>
      MinCertificate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MinCertificate(id: $id, x: $x, y: $y, fontUrl: $fontUrl, fontSize: $fontSize, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MinCertificate &&
        other.id == id &&
        other.x == x &&
        other.y == y &&
        other.fontUrl == fontUrl &&
        other.fontSize == fontSize &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        x.hashCode ^
        y.hashCode ^
        fontUrl.hashCode ^
        fontSize.hashCode ^
        photo.hashCode;
  }
}
