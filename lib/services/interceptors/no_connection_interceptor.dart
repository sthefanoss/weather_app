import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/services/weather_api_service.dart';

class NoConnectionInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_hasConnectionError(err)) {
      handler.reject(NoConnectionException(requestOptions: err.requestOptions));
      return;
    }
    super.onError(err, handler);
  }

  bool _hasConnectionError(DioException err) =>
      (err.type == DioExceptionType.unknown || err.type == DioExceptionType.connectionError) && //
      err.error is SocketException;
}
