import 'package:weather_app/services/responses/current_weather_response.dart';

abstract class WeatherApiService {
  Future<CurrentWeatherResponse> getCurrentWeather({required String location});
}

class OpenWeatherApiService implements WeatherApiService {
  final String apiKey;

  OpenWeatherApiService({required this.apiKey});

  @override
  Future<CurrentWeatherResponse> getCurrentWeather({required String location}) {
    //TODO
    throw UnimplementedError();
  }
}
