import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences sharedPreferences;

  initLocalStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
