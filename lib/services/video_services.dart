part of 'services.dart';

class VideoServices {
  String? token;

  VideoServices({required this.token});

  Future<ConfigVideoModel> getVideos({String? param}) async {
    http.Client? client;

    String url = "";

    if (param == null) {
      url = baseUrl + "/api/courses/videos?per_page=10";
    } else {
      url = param;
    }

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    ConfigVideoModel configTemp;

    configTemp = ConfigVideoModel.fromJson(json.decode(response.body));

    return configTemp;
  }

  Future<ConfigVideoModel> getVideosByType(
      {required String type}) async {
    
    http.Client? client;
    
    String url = baseUrl + "/api/courses/" + type + "/videos?per_page=10";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

   
    ConfigVideoModel configTemp;

    configTemp = ConfigVideoModel.fromJson(json.decode(response.body));

    return configTemp;
  }
}
