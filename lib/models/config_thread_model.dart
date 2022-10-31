part of 'models.dart';

class ConfigThreadModel {
  String? path;
  int perPage;
  String? nextPageUrl;
  String? prevPageUrl;
  List<ThreadModel> threads;

  ConfigThreadModel(
      {required this.path,
      required this.perPage,
      required this.prevPageUrl,
      required this.nextPageUrl,
      required this.threads});

  factory ConfigThreadModel.fromJson(Map<dynamic, dynamic> json) {
    ConfigThreadModel data = ConfigThreadModel(
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        nextPageUrl: json["next_page_url"],
        threads: List<ThreadModel>.from(
            json["data"].map((x) => ThreadModel.fromJson(x))));

    return data;
  }
}
