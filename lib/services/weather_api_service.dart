import 'package:dio/dio.dart';

import 'package:weather_app/services/responses/current_weather_response.dart';

abstract class WeatherApiService {
  Future<CurrentWeatherResponse> getCurrentWeather({required String location});
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
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  @override
  Future<CurrentWeatherResponse> getCurrentWeather({required String location}) async {
    final response = await _dio.get('/weather', queryParameters: {'q': location});
    return CurrentWeatherResponse.fromJson(response.data);
  }
}
