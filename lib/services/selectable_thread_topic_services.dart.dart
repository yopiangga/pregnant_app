part of 'services.dart';

class SelectableThreadTopicServices {
  String? token;

  SelectableThreadTopicServices({required this.token});

  Future<List<SelectableThreadTopicModel>> getTopics(
      {http.Client? client}) async {
    String url = baseUrl + "/api/threads/topics/selectable";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<SelectableThreadTopicModel> temp = [];

    if (response.statusCode != 200) {
      return temp;
    }

    List data = json.decode(response.body);

    temp = data.map((e) => SelectableThreadTopicModel.fromJson(e)).toList();
    return temp;
  }
}
