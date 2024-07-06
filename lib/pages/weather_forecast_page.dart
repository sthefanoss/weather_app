import 'package:get/get.dart';
import 'package:weather_app/controllers/weather_forecast_controller.dart';
import 'package:flutter/material.dart';

class WeatherForecastBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(WeatherForecastController());
  }
}

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});

  static const pageName = '/weater-forecast';

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
