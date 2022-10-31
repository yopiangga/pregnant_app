part of 'models.dart';

class CourseTypeModel {
  int id;
  int index;
  int enabled;
  int filterable;
  String name;
  String description;
  String? iconUrl;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  CourseTypeModel({
    required this.id,
    required this.index,
    required this.enabled,
    required this.filterable,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory CourseTypeModel.fromJson(Map<String, dynamic> json) {
    CourseTypeModel data = CourseTypeModel(
      id: json["id"],
      index: json["index"],
      enabled: json["enabled"],
      filterable: json["filterable"],
      name: json["name"],
      description: json["description"],
      iconUrl: json["icon_url"] ?? null,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
    );

    return data;
  }
}
