part of 'services.dart';

class UserServices {
  String? token;

  UserServices({required this.token});

  Future<UserProfileModel?> getUser({http.Client? client}) async {
    String url = baseUrl + "/api/user";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    UserProfileModel? temp;

    if (response.statusCode != 200) {
      return temp;
    }

    var data = json.decode(response.body);

    temp = UserProfileModel.fromJson(data);
    return temp;
  }

  Future<http.Response> editUser(
      {required String name, required String whatsappNumber}) async {
    String url = baseUrl + "/api/user";

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        'name': name ?? "",
        'whatsapp_number': whatsappNumber ?? "",
      }),
    );
  }

  Future<dynamic> editUserPhoto(
      {required Uint8List image, String? token}) async {
    String url = baseUrl + "/api/user/profile-photo";

    var request = http.MultipartRequest("POST", Uri.parse(url));

    var temp = http.MultipartFile.fromBytes(
      'profile_photo',
      image,
    );

    request.files.add(temp);

    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    var response = await request.send();
    // print(response.statusCode);
    // print(await response.stream.bytesToString());
    return response;
  }
}
