import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
