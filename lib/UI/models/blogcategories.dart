import 'dart:convert';

BlogCategories blogCategoriesFromJson(String str) =>
    BlogCategories.fromJson(json.decode(str));

String blogCategoriesToJson(BlogCategories data) => json.encode(data.toJson());

class BlogCategories {
  BlogCategories({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
    required this.photo,
    required this.slug,
    required this.blogPostCount,
    required this.v,
  });

  final Id id;
  final String name;
  final String color;
  final String description;
  final String photo;
  final String slug;
  final int blogPostCount;
  final int v;

  factory BlogCategories.fromJson(Map<String, dynamic> json) => BlogCategories(
        id: Id.fromJson(json["_id"]),
        name: json["name"],
        color: json["color"],
        description: json["description"],
        photo: json["photo"],
        slug: json["slug"],
        blogPostCount: json["blogPostCount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "name": name,
        "color": color,
        "description": description,
        "photo": photo,
        "slug": slug,
        "blogPostCount": blogPostCount,
        "__v": v,
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
