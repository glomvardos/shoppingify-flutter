import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences _sharedPrefs;

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  getKey(String key) => _sharedPrefs.getString(key);

  addKey(String key, String value) async {
    await _sharedPrefs.setString(key, value);
  }

  removeKey(String key) async {
    await _sharedPrefs.remove(key);
  }
}

final sharedPrefs = SharedPrefs();
