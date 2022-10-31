part of 'models.dart';

class UserModel {
  int id;
  String identifier;
  String name;
  String email;
  String phoneNumber;
  dynamic profileDescription;
  String profilePhotoPath;
  int institutionId;
  int privilegesLevel;
  int experienceLevelId;
  int experiencePoint;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  UserModel({
    required this.id,
    required this.identifier,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileDescription,
    required this.profilePhotoPath,
    required this.institutionId,
    required this.privilegesLevel,
    required this.experienceLevelId,
    required this.experiencePoint,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel data = UserModel(
      id: json["id"],
      identifier: json["identifier"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      profileDescription: json["profile_description"],
      profilePhotoPath: json["profile_photo_path"],
      institutionId: json["institution_id"],
      privilegesLevel: json["privileges_level"],
      experienceLevelId: json["experience_level_id"],
      experiencePoint: json["experience_point"],
      emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
    );

    return data;
  }
}
