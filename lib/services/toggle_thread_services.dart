part of 'services.dart';

class ToggleThreadServices {
  String? token;

  ToggleThreadServices({required this.token});

  Future<dynamic> threadLike({required String idThread}) async {
    String url = baseUrl + "/api/threads/" + idThread + "/likes/toggle";

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    var response = await request.send();

    return response;
  }

  Future<dynamic> threadStar({required String idThread}) async {
    String url = baseUrl + "/api/threads/" + idThread + "/stars/toggle";

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    var response = await request.send();

    return response;
  }

  Future<dynamic> threadStarReply(
      {required String idThread, required String idReply}) async {
    String url = baseUrl +
        "/api/threads/" +
        idThread +
        "/replies/" +
        idReply +
        "/stars/toggle";

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    var response = await request.send();

    return response;
  }
}
