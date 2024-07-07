import 'dart:convert';

class CacheWrapper<T> {
  final T data;
  final DateTime expiryDate;

  const CacheWrapper(this.data, this.expiryDate);

  String encode(Map<String, dynamic> Function(T) encode) {
    final dataWithTimestamp = {
      'data': encode(data),
      'expiryDate': expiryDate.toIso8601String(),
    };

    return jsonEncode(dataWithTimestamp);
  }

  factory CacheWrapper.decode(String json, T Function(Map<String, dynamic>) decode) {
    final dataWithTimestamp = jsonDecode(json) as Map<String, dynamic>;

    return CacheWrapper(
      decode(dataWithTimestamp['data'] as Map<String, dynamic>),
      DateTime.parse(dataWithTimestamp['expiryDate'] as String),
    );
  }
}
