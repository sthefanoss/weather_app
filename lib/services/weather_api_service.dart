import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/services/interceptors/no_connection_interceptor.dart';

import 'package:weather_app/services/responses/current_weather_response.dart';
import 'package:weather_app/services/responses/weather_forecast_response.dart';

abstract class WeatherApiService {
  Future<CurrentWeatherResponse> getCurrentWeather({required String location});

  Future<WeatherForecastResponse> getWeatherForecast({required String location});
}

class OpenWeatherApiService implements WeatherApiService {
  final String apiKey;
  final Dio _dio;

  OpenWeatherApiService({required this.apiKey})
      : _dio = Dio(
          BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5', queryParameters: {
            'appid': apiKey,
            'units': 'metric',
          }),
        ) {
    _dio.interceptors.addAll([
      LogInterceptor(responseBody: true, requestBody: true),
      NoConnectionInterceptor(),
    ]);
  }

  @override
  Future<CurrentWeatherResponse> getCurrentWeather({required String location}) async {
    final response = await _dio.get('/weather', queryParameters: {'q': location});
    return CurrentWeatherResponse.fromJson(response.data);
  }

  @override
  Future<WeatherForecastResponse> getWeatherForecast({required String location}) async {
    final response = await _dio.get('/forecast', queryParameters: {'q': location});
    return WeatherForecastResponse.fromJson(response.data);
  }
}

class NoConnectionException extends DioException {
  NoConnectionException({required super.requestOptions})
      : super(
          type: DioExceptionType.connectionError,
          error: const SocketException('No connection'),
        );
}
