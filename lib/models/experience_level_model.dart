part of 'models.dart';

class ExperienceLevelModel {
  int id;
  int level;
  String name;
  int targetPoint;
  DateTime createdAt;
  DateTime updatedAt;

  ExperienceLevelModel({
    required this.id,
    required this.level,
    required this.name,
    required this.targetPoint,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExperienceLevelModel.fromJson(Map<String, dynamic> json) {
    ExperienceLevelModel data = ExperienceLevelModel(
        id: json["id"],
        level: json["level"],
        name: json["name"],
        targetPoint: json["target_point"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]));

    return data;
  }
}
