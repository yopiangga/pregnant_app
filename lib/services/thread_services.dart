part of 'services.dart';

class ThreadServices {
  String? token;

  ThreadServices({required this.token});

  Future<ConfigThreadModel> getThreads({String? param}) async {
    http.Client? client;

    String url = "";

    if (param == null) {
      url = baseUrl + "/api/threads?per_page=10";
    } else {
      url = param;
    }

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    ConfigThreadModel configTemp;

    // if (response.statusCode != 200) {
    //   return configTemp;
    // }

    configTemp = ConfigThreadModel.fromJson(json.decode(response.body));

    return configTemp;
  }

  Future<dynamic> postThread(
      {required String title,
      required String body,
      required String courseTypeId}) async {
    String url = baseUrl + "/api/threads";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'body': body,
        'course_type_id': courseTypeId
      }),
    );

    return response;
  }

  Future<dynamic> postReplyThread(
      {required String body, required String threadId}) async {
    String url = baseUrl + "/api/threads/" + threadId + "/replies";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'body': body,
      }),
    );

    return response;
  }
}
