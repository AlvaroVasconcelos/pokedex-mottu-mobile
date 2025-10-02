import 'package:shared_preferences/shared_preferences.dart';

import 'cache_store.dart';

class SharedPrefsCacheStore implements CacheStore {
  const SharedPrefsCacheStore();

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  @override
  Future<String?> read(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<void> write(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }
}
