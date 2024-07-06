import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/current_weather_controller.dart';

class CurrentWeatherBindings extends Bindings {
  @override
  void dependencies() {
    assert(
      Get.arguments is CurrentWeatherArguments,
      'CurrentWeatherArguments is required as arguments when calling "Get.toNamed"',
    );
    final arguments = Get.arguments as CurrentWeatherArguments;

    Get.put(CurrentWeatherController(location: arguments.location));
  }
}

class CurrentWeatherArguments {
  final String location;

  const CurrentWeatherArguments({required this.location});
}

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  static const pageName = '/current-weather';

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final controller = Get.find<CurrentWeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Weather')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                controller.location,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
