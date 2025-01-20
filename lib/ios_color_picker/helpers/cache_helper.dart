import 'package:shared_preferences/shared_preferences.dart';

///Local Data Helper
class CacheHelper {
  /// Singleton instance
  static final CacheHelper _instance = CacheHelper._internal();

  /// SharedPreferences instance
  late SharedPreferences _sharedPreferences;

  static bool _isInitialized = false;

  /// Private constructor
  CacheHelper._internal();

  /// Factory constructor to return the singleton instance
  factory CacheHelper() => _instance;

  /// Ensure initialization is done once
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  /// Public initialization method for optional explicit init
  static Future<void> init() async {
    await _instance._ensureInitialized();
  }

  /// Save data
  Future<bool> setData<T>({
    required String key,
    required T value,
  }) async {
    await _ensureInitialized();
    switch (value) {
      case String _:
        return await _sharedPreferences.setString(key, value);
      case bool _:
        return await _sharedPreferences.setBool(key, value);
      case int _:
        return await _sharedPreferences.setInt(key, value);
      case double _:
        return await _sharedPreferences.setDouble(key, value);
      case List<String> _:
        return await _sharedPreferences.setStringList(key, value);
      default:
        throw ArgumentError('Unsupported type');
    }
  }

  /// Get data
  dynamic getData({required String key}) async {
    await _ensureInitialized();
    return _sharedPreferences.get(key);
  }

  /// Clear specific data
  Future<bool> clearData({required String key}) async {
    await _ensureInitialized();
    return await _sharedPreferences.remove(key);
  }

  /// Clear all data
  Future<bool> clearAllData() async {
    await _ensureInitialized();
    return await _sharedPreferences.clear();
  }
}
