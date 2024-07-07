import 'package:get/get.dart';
import 'package:weather_app/models/cache_wrapper.dart';
import 'package:weather_app/services/local_storage_service.dart';

mixin CachedControllerMixin<T extends Object> {
  Duration get cacheDuration;

  String get cacheKey;

  T cacheDecode(Map<String, dynamic> value);

  Map<String, dynamic> cacheEncode(T value);

  Future<void> updateCache(T data) {
    final reference = DateTime.now();
    return Get.find<LocalStorageService>().saveString(
      key: cacheKey,
      value: CacheWrapper(
        data: data,
        timestamp: reference,
        expiryDate: DateTime.now().add(cacheDuration),
      ).encode(cacheEncode),
    );
  }

  CacheWrapper<T>? getCachedData({bool ignoreExpiryTime = false}) {
    try {
      final cachedValue = Get.find<LocalStorageService>().getString(key: cacheKey);
      if (cachedValue == null) return null;

      final decoded = CacheWrapper<T>.decode(cachedValue, cacheDecode);
      if (!ignoreExpiryTime && decoded.expiryDate.isBefore(DateTime.now())) {
        return null;
      }

      return decoded;
    } catch (e) {
      return null;
    }
  }
}
