part of 'models.dart';

class InstitutionModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  InstitutionModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory InstitutionModel.fromJson(Map<dynamic, dynamic> json) {
    InstitutionModel data = InstitutionModel(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"] == null
          ? null
          : DateTime.parse(json["deleted_at"]),
    );

    return data;
  }
}
