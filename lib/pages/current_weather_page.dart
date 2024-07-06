import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/current_weather_controller.dart';

class CurrentWeatherBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CurrentWeatherController());
  }
}

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  static const pageName = '/current-weather';

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
