part of 'models.dart';

class Reply {
  int id;
  int threadId;
  int userId;
  String body;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int replyStarsCount;
  UserModel user;

  Reply(
      {required this.id,
      required this.threadId,
      required this.userId,
      required this.body,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.replyStarsCount,
      required this.user});

  factory Reply.fromJson(Map<dynamic, dynamic> json) {
    Reply data = Reply(
      id: json["id"],
      threadId: json["thread_id"],
      userId: json["user_id"],
      body: json["body"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
      replyStarsCount: json["reply_stars_count"],
      user: UserModel.fromJson(json["user"]),
    );

    return data;
  }
}
