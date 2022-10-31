part of 'methods.dart';

Future<bool> setToken(String data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', data);
  return true;
}
