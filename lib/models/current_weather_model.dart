import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/responses/current_weather_response.dart';

class CurrentWeatherModel extends Equatable {
  final double rain;
  final double snow;
  final int humidity;
  final double windSpeed;
  final double temperature;
  final List<WeatherModel> weather;

  const CurrentWeatherModel({
    required this.rain,
    required this.snow,
    required this.humidity,
    required this.windSpeed,
    required this.temperature,
    required this.weather,
  });

  CurrentWeatherModel.fromJson(Map<String, dynamic> json)
      : rain = (json['rain'] as num?)?.toDouble() ?? 0,
        snow = (json['snow'] as num?)?.toDouble() ?? 0,
        humidity = json['humidity'],
        windSpeed = json['windSpeed'],
        temperature = json['temperature'],
        weather = (json['weather'] as List).map((i) => WeatherModel.fromJson(i)).toList();

  CurrentWeatherModel.fromCurrentWeatherResponse(CurrentWeatherResponse response)
      : rain = (response.rain?.oneHour ?? response.rain?.threeHours)?.toDouble() ?? 0,
        snow = (response.snow?.oneHour ?? response.snow?.threeHours)?.toDouble() ?? 0,
        humidity = response.main.humidity,
        windSpeed = response.wind.speed,
        temperature = response.main.temp,
        weather = response.weather.map(WeatherModel.fromWeather).toList();

  Map<String, dynamic> toJson() => {
        'rain': rain,
        'snow': snow,
        'humidity': humidity,
        'windSpeed': windSpeed,
        'temperature': temperature,
        'weather': weather.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [rain, snow, humidity, windSpeed, temperature, weather];
}
