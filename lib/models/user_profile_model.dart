part of 'models.dart';

class UserProfileModel extends UserModel {
  ExperienceLevelModel experienceLevel;
  ExperienceLevelModel nextExperienceLevel;
  int nextExperienceLevelPercentage;

  UserProfileModel({
    required super.id,
    required super.identifier,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.profileDescription,
    required super.profilePhotoPath,
    required super.institutionId,
    required super.privilegesLevel,
    required super.experienceLevelId,
    required super.experiencePoint,
    required super.emailVerifiedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.experienceLevel,
    required this.nextExperienceLevel,
    required this.nextExperienceLevelPercentage,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    UserProfileModel data = UserProfileModel(
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
        experienceLevel:
            ExperienceLevelModel.fromJson(json["experience_level"]),
        nextExperienceLevel:
            ExperienceLevelModel.fromJson(json["next_experience_level"]),
        nextExperienceLevelPercentage:
            json["next_experience_level_percentage"]);

    return data;
  }
}
