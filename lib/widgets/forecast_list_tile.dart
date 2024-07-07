import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_forecast_model.dart';
import 'package:weather_app/widgets/weather_info.dart';

class ForecastListTile extends StatelessWidget {
  const ForecastListTile({required this.forecastEntry, super.key});
  final WeatherForecasEntry forecastEntry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: forecastEntry.weather.first.iconUrl,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(DateFormat('dd/MM HH:mm').format(forecastEntry.timestamp)),
          ),
        ],
      ),
      title: Text(forecastEntry.weather.first.description.capitalize!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeatherInfo(title: 'Temperature', value: forecastEntry.temperature, unit: '°C'),
          WeatherInfo(title: 'Rain', value: forecastEntry.rain, unit: 'mm'),
          WeatherInfo(title: 'Snow', value: forecastEntry.snow, unit: 'mm'),
          WeatherInfo(title: 'Humidity', value: forecastEntry.humidity, unit: '%'),
          WeatherInfo(title: 'Wind', value: forecastEntry.windSpeed, unit: 'm/s'),
        ],
      ),
    );
  }
}
