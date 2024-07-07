import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/responses/weather_forecast_response.dart';

class WeatherForecastModel extends Equatable {
  final List<WeatherForecasEntry> entries;

  const WeatherForecastModel({required this.entries});

  WeatherForecastModel.fromJson(Map<String, dynamic> value)
      : entries = (value['entries'] as List).map((e) => WeatherForecasEntry.fromJson(e)).toList();

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

  Map<String, dynamic> toJson() => {
        'entries': entries.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [entries];
}

class WeatherForecasEntry extends Equatable {
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

  WeatherForecasEntry.fromJson(Map<String, dynamic> value)
      : timestamp = DateTime.fromMillisecondsSinceEpoch(value['timestamp']),
        temperature = value['temperature'],
        rain = value['rain'],
        snow = value['snow'],
        humidity = value['humidity'],
        windSpeed = value['windSpeed'],
        weather = (value['weather'] as List).map((e) => WeatherModel.fromJson(e)).toList();

  @override
  List<Object?> get props => [
        timestamp,
        temperature,
        rain,
        snow,
        humidity,
        windSpeed,
        weather,
      ];

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.millisecondsSinceEpoch,
        'temperature': temperature,
        'rain': rain,
        'snow': snow,
        'humidity': humidity,
        'windSpeed': windSpeed,
        'weather': weather.map((e) => e.toJson()).toList(),
      };
}
