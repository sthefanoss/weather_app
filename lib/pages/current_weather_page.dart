import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
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
                    onPressed: controller.fetchCurrentWeather,
                    child: const Text('Retry'),
                  )
                ],
              );
            }

            if (state case SuccessState(:final data)) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final String title;
  final num value;
  final String unit;
  final TextStyle? style;

  const WeatherInfo({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? Theme.of(context).textTheme.bodyLarge;
    return RichText(
      text: TextSpan(
        style: effectiveStyle,
        children: [
          TextSpan(text: '$title: ', style: effectiveStyle?.copyWith(fontWeight: FontWeight.bold)),
          TextSpan(text: '$value'),
          TextSpan(text: unit, style: effectiveStyle?.copyWith(fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
