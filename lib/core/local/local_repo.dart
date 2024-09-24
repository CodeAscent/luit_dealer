import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';

class LocalRepo {
  static Future saveLocalData(String key, String value) async {
    await LocalStorage.sharedPreferences.setString(key, value);
  }

  static Future removeLocalData(String key) async {
    await LocalStorage.sharedPreferences.remove(key);
  }

  static fetchLocalData(String key) async {
    final data = await LocalStorage.sharedPreferences.getString(key);
    return data;
  }
}
