import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/services/weather_api_service.dart';
import 'package:weather_app/weather_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  Get.put<LocalStorageService>(
    await HiveLocalStorageService.instance('weather_app'),
  );

  Get.put<WeatherApiService>(
    OpenWeatherApiService(apiKey: dotenv.env['OPEN_WEATHER_API_KEY']!),
  );

  runApp(
    DevicePreview(
      enabled: dotenv.env['DEVICE_PREVIEW'] == 'TRUE',
      builder: (context) => const WeatherApp(), // Wrap your app
    ),
  );
}
