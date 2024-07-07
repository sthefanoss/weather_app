import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/controllers/weather_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_info.dart';

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
          Obx(() {
            final state = controller.state.value;

            if (state is ErrorState) {
              return Column(
                children: [
                  const Text('There was an error, please try again.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.getWeatherForecast,
                    child: const Text('Retry'),
                  )
                ],
              );
            }

            if (state case SuccessState(:final data) || CachedState(:final data)) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemCount: data.entries.length,
                    itemBuilder: (context, index) {
                      final element = data.entries[index];
                      return ListTile(
                        leading: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: element.weather.first.iconUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Text(DateFormat('dd/MM HH:mm').format(element.timestamp)),
                            ),
                          ],
                        ),
                        title: Text(element.weather.first.description.capitalize!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WeatherInfo(title: 'Temperature', value: element.temperature, unit: '°C'),
                            WeatherInfo(title: 'Rain', value: element.rain, unit: 'mm'),
                            WeatherInfo(title: 'Snow', value: element.snow, unit: 'mm'),
                            WeatherInfo(title: 'Humidity', value: element.humidity, unit: '%'),
                            WeatherInfo(title: 'Wind', value: element.windSpeed, unit: 'm/s'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
        ],
      ),
    );
  }
}
