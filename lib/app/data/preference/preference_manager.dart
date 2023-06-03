import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String keyToken = 'token';

  final SharedPreferences _preferences;

  PreferenceManager(this._preferences);

  Future<void> saveToken(String token) async {
    await _preferences.setString(keyToken, token);
  }

  String? getToken() {
    return _preferences.getString(keyToken);
  }

  Future<void> removeToken() async {
    await _preferences.remove(keyToken);
  }
}

