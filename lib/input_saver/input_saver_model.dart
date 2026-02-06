import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class InputSaver {
  static const String _cacheFileName = 'input_cache.json';
  // 内存缓存作为后备方案
  static final Map<String, Map<String, dynamic>> _memoryCache = {};

  // 保存输入内容到本地缓存
  static Future<void> saveInput(String key, String value) async {
    // 先保存到内存缓存
    _memoryCache[key] = {
      'value': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    // 尝试保存到本地文件，但不打印错误信息
    try {
      final cache = await _loadCache();
      cache[key] = {
        'value': value,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await _saveCache(cache);
    } catch (e) {
      // 静默处理错误，依赖内存缓存
    }
  }

  // 从本地缓存加载输入内容
  static Future<String?> loadInput(String key) async {
    // 先检查内存缓存
    if (_memoryCache.containsKey(key)) {
      final cacheItem = _memoryCache[key];
      if (cacheItem != null) {
        final value = cacheItem['value'];
        return value;
      }
    }

    // 尝试从本地文件加载，但不打印错误信息
    try {
      final cache = await _loadCache();
      if (cache.containsKey(key)) {
        final value = cache[key]['value'];
        // 同步到内存缓存
        _memoryCache[key] = cache[key];
        return value;
      }
    } catch (e) {
      // 静默处理错误，依赖内存缓存
    }

    return null;
  }

  // 清除指定键的缓存
  static Future<void> clearInput(String key) async {
    // 清除内存缓存
    _memoryCache.remove(key);

    // 尝试清除本地文件缓存，但不打印错误信息
    try {
      final cache = await _loadCache();
      cache.remove(key);
      await _saveCache(cache);
    } catch (e) {
      // 静默处理错误，依赖内存缓存
    }
  }

  // 清除所有缓存
  static Future<void> clearAll() async {
    // 清除内存缓存
    _memoryCache.clear();

    // 尝试清除本地文件缓存，但不打印错误信息
    try {
      await _saveCache({});
    } catch (e) {
      // 静默处理错误，依赖内存缓存
    }
  }

  // 加载缓存文件
  static Future<Map<String, dynamic>> _loadCache() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_cacheFileName');
      if (file.existsSync()) {
        final content = await file.readAsString();
        return json.decode(content);
      }
    } catch (e) {
      // 静默处理错误，返回空缓存
    }
    return {};
  }

  // 保存缓存文件
  static Future<void> _saveCache(Map<String, dynamic> cache) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_cacheFileName');
      await file.writeAsString(json.encode(cache));
    } catch (e) {
      // 静默处理错误
    }
  }
}

// 输入框配置类
class InputFieldConfig {
  final String key;
  final String hintText;
  final int maxLines;
  final bool autofocus;

  InputFieldConfig({
    required this.key,
    required this.hintText,
    this.maxLines = 1,
    this.autofocus = false,
  });
}
