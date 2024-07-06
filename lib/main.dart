import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weather_app.dart';

import 'services/api_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  Get.put<WeatherApiService>(
    OpenWeatherApiService(apiKey: dotenv.env['OPEN_WEATHER_API_KEY']!),
  );

  runApp(const WeatherApp());
}
