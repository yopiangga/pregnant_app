part of 'models.dart';

class ThreadModel {
  int id;
  String uuid;
  int userId;
  int courseTypeId;
  int? institutionId;
  String title;
  String body;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int repliesCount;
  int threadLikesCount;
  int threadStarsCount;
  String slug;
  UserModel user;
  InstitutionModel? institution;
  CourseTypeModel courseType;
  List<Reply> replies;

  ThreadModel({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.courseTypeId,
    required this.institutionId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.repliesCount,
    required this.threadLikesCount,
    required this.threadStarsCount,
    required this.slug,
    required this.user,
    required this.institution,
    required this.courseType,
    required this.replies,
  });

  factory ThreadModel.fromJson(Map<dynamic, dynamic> json) {
    ThreadModel data = ThreadModel(
      id: json["id"],
      uuid: json["uuid"],
      userId: json["user_id"],
      courseTypeId: json["course_type_id"],
      institutionId: json["institution_id"],
      title: json["title"],
      body: json["body"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
      repliesCount: json["replies_count"],
      threadLikesCount: json["thread_likes_count"],
      threadStarsCount: json["thread_stars_count"],
      slug: json["slug"],
      user: UserModel.fromJson(json["user"]),
      institution: json["institution"] == null
          ? null
          : InstitutionModel.fromJson(json["institution"]),
      courseType: CourseTypeModel.fromJson(json["course_type"]),
      replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
    );

    return data;
  }
}
