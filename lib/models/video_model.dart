part of 'models.dart';

class VideoModel {
  int id;
  int index;
  int? priorityLevel;
  int? experienceLevelId;
  int courseTypeId;
  int userId;
  String title;
  String? description;
  String url;
  dynamic thumbnailUrl;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  UserModel user;

  VideoModel({
    required this.id,
    required this.index,
    required this.priorityLevel,
    required this.experienceLevelId,
    required this.courseTypeId,
    required this.userId,
    required this.title,
    required this.description,
    required this.url,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    VideoModel data = VideoModel(
      id: json["id"],
      index: json["index"],
      priorityLevel: json["priority_level"],
      experienceLevelId: json["experience_level_id"],
      courseTypeId: json["course_type_id"],
      userId: json["user_id"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      thumbnailUrl: json["thumbnail_url"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
      user: UserModel.fromJson(json["user"]),
    );

    return data;
  }
}
