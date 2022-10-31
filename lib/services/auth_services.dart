part of 'services.dart';

class AuthServices {
  static Future<http.Response> login(
      {required String email, required String password}) async {
    String url = baseUrl + "/api/login";

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email ?? "",
        'password': password ?? "",
      }),
    );
  }
}
