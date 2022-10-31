part of 'providers.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileModel? tempUser;
  UserProfileModel? get user => tempUser;

  Future<void> setUser(UserProfileModel? user) async {
    tempUser = user;
    notifyListeners();
  }
}
