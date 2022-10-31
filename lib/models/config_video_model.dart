part of 'models.dart';

class ConfigVideoModel {
  String? path;
  int perPage;
  String? nextPageUrl;
  String? prevPageUrl;
  List<VideoModel> videos;

  ConfigVideoModel(
      {required this.path,
      required this.perPage,
      required this.prevPageUrl,
      required this.nextPageUrl,
      required this.videos});

  factory ConfigVideoModel.fromJson(Map<dynamic, dynamic> json) {
    ConfigVideoModel data = ConfigVideoModel(
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        nextPageUrl: json["next_page_url"],
        videos: List<VideoModel>.from(
            json["data"].map((x) => VideoModel.fromJson(x))));

    return data;
  }
}
