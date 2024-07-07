import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/responses/weather_forecast_response.dart';

class WeatherForecastModel {
  const WeatherForecastModel(this.entries);

  final List<WeatherForecasEntry> entries;

  WeatherForecastModel.fromWeatherForecastResponse(WeatherForecastResponse response)
      : entries = response.list.map(
          (e) {
            return WeatherForecasEntry(
              timestamp: DateTime.fromMillisecondsSinceEpoch(e.dt * 1000),
              temperature: e.main.temp,
              rain: e.rain?.oneHour ?? e.rain?.threeHours ?? 0,
              snow: e.snow?.oneHour ?? e.snow?.threeHours ?? 0,
              humidity: e.main.humidity,
              windSpeed: e.wind.speed,
              weather: e.weather.map((e) => WeatherModel.fromWeather(e)).toList(),
            );
          },
        ).toList();
}

class WeatherForecasEntry {
  final DateTime timestamp;
  final double temperature;
  final double rain;
  final double snow;
  final int humidity;
  final double windSpeed;
  final List<WeatherModel> weather;

  const WeatherForecasEntry({
    required this.timestamp,
    required this.temperature,
    required this.rain,
    required this.snow,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });
}
