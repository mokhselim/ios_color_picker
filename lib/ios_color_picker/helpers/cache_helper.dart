
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<SharedPreferences> init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData<T>({
    required String key,
    required T value,
  }) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    switch (value) {
      case String _:
        return await _sharedPreferences.setString(key, value);
      case bool _:
        return await _sharedPreferences.setBool(key, value);
      case int _:
        return await _sharedPreferences.setInt(key, value);
      case double _:
        return await _sharedPreferences.setDouble(key, value);
      case   List<String> _:
        return await _sharedPreferences.setStringList(
            key, value );
    }
    return await _sharedPreferences.setString(key, value as String);
  }

  static getData({
    required String key,
  }) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> clearData({
    required String key,
  }) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await _sharedPreferences.clear();
  }
}
