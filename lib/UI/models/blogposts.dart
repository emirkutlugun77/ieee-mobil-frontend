import 'dart:convert';

BlogPost blogPostFromJson(String str) => BlogPost.fromJson(json.decode(str));

String blogPostToJson(BlogPost data) => json.encode(data.toJson());

class BlogPost {
  BlogPost({
    required this.id,
    required this.blogCategoryId,
    required this.likedBy,
    required this.tags,
    required this.userId,
    required this.text,
    required this.title,
    required this.photo,
    required this.slug,
    required this.viewCount,
    required this.date,
    required this.v,
  });

  final String id;
  final BlogCategoryId blogCategoryId;
  final List<String> likedBy;
  final List<String> tags;
  final UserId userId;
  final String text;
  final String title;
  final String photo;
  final String slug;
  final int viewCount;
  final DateTime date;
  final int v;

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
        id: json["_id"],
        blogCategoryId: BlogCategoryId(
          id: json['blogCategoryId'][0]['_id'],
          name: json['blogCategoryId'][0]['name'],
          color: json['blogCategoryId'][0]['color'],
          description: json['blogCategoryId'][0]['description'],
        ),
        likedBy: json["likedBy"] != null
            ? List<String>.from(json["likedBy"].map((x) => x.toString()))
            : [],
        tags: List<String>.from(json["tags"].map((x) => x.toString())),
        userId: UserId.fromJson(json["userId"]),
        text: json["text"],
        title: json["title"],
        photo: json["photo"] != null ? json['photo'] : '',
        slug: json["slug"],
        viewCount: json["viewCount"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "blogCategoryId": blogCategoryId,
        "likedBy": List<dynamic>.from(likedBy.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "userId": userId,
        "text": text,
        "title": title,
        "photo": photo,
        "slug": slug,
        "viewCount": viewCount,
        "date": date,
        "__v": v,
      };
}

class BlogCategoryId {
  final String id;
  final String name;
  final String color;
  final String description;

  BlogCategoryId({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'description': description,
    };
  }

  factory BlogCategoryId.fromJson(Map<String, dynamic> map) {
    return BlogCategoryId(
      id: map[0],
      name: map[1],
      color: map[2],
      description: map[3],
    );
  }
}

class UserId {
  final String photoSm;
  final String photoXs;

  final String id;
  final String name;
  final String surname;
  final String username;
  UserId({
    required this.photoSm,
    required this.photoXs,
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
  });

  UserId copyWith({
    String? photoSm,
    String? photoXs,
    String? id,
    String? name,
    String? surname,
    String? username,
  }) {
    return UserId(
      photoSm: photoSm ?? this.photoSm,
      photoXs: photoXs ?? this.photoXs,
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoSm': photoSm,
      'photoXs': photoXs,
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
    };
  }

  factory UserId.fromJson(Map<String, dynamic> map) {
    return UserId(
      photoSm: map['photoSm'] != null ? map['photoSm'] : '',
      photoXs: map['photoXs'] != null ? map['photoXs'] : '',
      id: map['_id'],
      name: map['name'],
      surname: map['surname'],
      username: map['username'],
    );
  }
}
