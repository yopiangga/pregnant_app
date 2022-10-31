part of 'services.dart';

class AnnouncementServices {
  static Future<List<AnnouncementModel>> getAnnouncement(
      {http.Client? client, String? token}) async {
    String url = baseUrl + "/api/announcements";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<AnnouncementModel> temp = [];

    if (response.statusCode != 200) {
      return temp;
    }

    List data = json.decode(response.body);

    temp = data.map((e) => AnnouncementModel.fromJson(e)).toList();

    return temp;
  }
}
