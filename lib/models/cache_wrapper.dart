import 'dart:convert';

class CacheWrapper<T> {
  final T data;
  final DateTime expiryDate;
  final DateTime timestamp;

  const CacheWrapper({required this.data, required this.timestamp, required this.expiryDate});

  String encode(Map<String, dynamic> Function(T) encode) {
    final dataWithMeta = {
      'data': encode(data),
      'expiryDate': expiryDate.toIso8601String(),
      'timestamp': timestamp.toIso8601String(),
    };

    return jsonEncode(dataWithMeta);
  }

  factory CacheWrapper.decode(String json, T Function(Map<String, dynamic>) decode) {
    final dataWithMeta = jsonDecode(json) as Map<String, dynamic>;

    return CacheWrapper(
      data: decode(dataWithMeta['data'] as Map<String, dynamic>),
      expiryDate: DateTime.parse(dataWithMeta['expiryDate'] as String),
      timestamp: DateTime.parse(dataWithMeta['timestamp'] as String),
    );
  }
}
