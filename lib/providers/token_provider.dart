part of 'providers.dart';

class TokenProvider extends ChangeNotifier {
  String tempToken = "";

  String get token => tempToken;
}
