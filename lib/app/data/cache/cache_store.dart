import 'package:flutter/foundation.dart';

@immutable
abstract class CacheStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
}
