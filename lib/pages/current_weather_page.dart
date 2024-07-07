import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/controllers/current_weather_controller.dart';
import 'package:weather_app/pages/weather_forecast_page.dart';
import 'package:weather_app/widgets/weather_info.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24) + const EdgeInsets.only(top: 24),
            child: Text(
              controller.location,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            final state = controller.state.value;

            if (state case ErrorState(:final offline)) {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  if (offline)
                    const Text(
                      'You are offline! Please, verify your connection.',
                      textAlign: TextAlign.center,
                    )
                  else
                    const Text('There was an error, please try again.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.getCurrentWeather,
                    child: const Text('Retry'),
                  )
                ],
              );
            }

            if (state case SuccessState(:final data) || CachedState(:final data)) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state case CachedState(:final lastUpdated, :final offline)) ...[
                      Text(
                        'Last update ${DateFormat('dd/MM HH:mm').format(lastUpdated)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (offline)
                        Text(
                          'You are offline! Please, verify your connection.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                    const SizedBox(height: 8),
                    WeatherInfo(
                      title: 'Temperature',
                      value: data.temperature,
                      unit: '°C',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Wrap(
                      children: [
                        for (final weather in data.weather)
                          Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: weather.iconUrl,
                                width: 128,
                                height: 128,
                                fit: BoxFit.cover,
                              ),
                              Text(weather.description.capitalize!),
                            ],
                          )
                      ],
                    ),
                    const SizedBox(height: 24),
                    WeatherInfo(title: 'Rain', value: data.rain, unit: 'mm'),
                    WeatherInfo(title: 'Snow', value: data.snow, unit: 'mm'),
                    WeatherInfo(title: 'Humidity', value: data.humidity, unit: '%'),
                    WeatherInfo(title: 'Wind', value: data.windSpeed, unit: 'm/s'),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Forecast'),
        icon: const Icon(Icons.area_chart_rounded),
        onPressed: () => Get.toNamed(
          WeatherForecastPage.pageName,
          arguments: WeatherForecastArguments(location: controller.location),
        ),
      ),
    );
  }
}
