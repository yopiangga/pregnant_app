part of 'models.dart';

class AnnouncementModel {
  String title;
  String? body;
  String? url;

  AnnouncementModel(
      {required this.title, required this.body, required this.url});

  factory AnnouncementModel.fromJson(Map<dynamic, dynamic> json) {
    AnnouncementModel data = AnnouncementModel(
        title: json['title'], body: json['body'], url: json['url']);

    return data;
  }
}
