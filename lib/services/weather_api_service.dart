abstract class WeatherApiService {}

class OpenWeatherApiService implements WeatherApiService {
  final String apiKey;

  OpenWeatherApiService({required this.apiKey});
}
