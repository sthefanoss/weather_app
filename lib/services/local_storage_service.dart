import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorageService {
  Future<void> saveString({required String key, required String value});
  String? getString({required String key});
}

class HiveLocalStorageService implements LocalStorageService {
  static Future<HiveLocalStorageService> instance(String name) async {
    await Hive.initFlutter();
    final hiveBox = await Hive.openBox<String>(name);
    return HiveLocalStorageService._(hiveBox);
  }

  const HiveLocalStorageService._(this._hiveBox);
  final Box<String> _hiveBox;

  @override
  String? getString({required String key}) => _hiveBox.get(key);

  @override
  Future<void> saveString({required String key, required String value}) => _hiveBox.put(key, value);
}
