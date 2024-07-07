import 'package:get/get.dart';
import 'package:weather_app/controllers/weather_forecast_controller.dart';
import 'package:flutter/material.dart';

class WeatherForecastBindings extends Bindings {
  @override
  void dependencies() {
    assert(
      Get.arguments is WeatherForecastArguments,
      'WeatherForecastArguments is required as arguments when calling "Get.toNamed"',
    );
    final arguments = Get.arguments as WeatherForecastArguments;

    Get.put(WeatherForecastController(location: arguments.location));
  }
}

class WeatherForecastArguments {
  final String location;

  const WeatherForecastArguments({required this.location});
}

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});

  static const pageName = '/weater-forecast';

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  final controller = Get.find<WeatherForecastController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Weather')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              controller.location,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
