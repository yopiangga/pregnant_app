part of 'services.dart';

class CourseTypeServices {
  static Future<List<CourseTypeModel>> getCategorys(
      {http.Client? client, String? token}) async {
    String url = baseUrl + "/api/courses";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<CourseTypeModel> temp = [];

    if (response.statusCode != 200) {
      return temp;
    }

    List data = json.decode(response.body);

    temp = data.map((e) => CourseTypeModel.fromJson(e)).toList();
    return temp;
  }
}
