part of 'methods.dart';

String getIDVideo(String url) {
  return url.split("=")[1].split("&").first;
}
