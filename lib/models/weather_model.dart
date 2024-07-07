import 'package:equatable/equatable.dart';
import 'package:weather_app/services/responses/shared.dart';

class WeatherModel extends Equatable {
  final String description;
  final String iconUrl;

  const WeatherModel({
    required this.description,
    required this.iconUrl,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        iconUrl = json['iconUrl'];

  WeatherModel.fromWeather(Weather weather)
      : description = weather.description,
        iconUrl = weather.iconUrl;

  Map<String, dynamic> toJson() => {
        'description': description,
        'iconUrl': iconUrl,
      };

  @override
  List<Object?> get props => [description, iconUrl];
}
