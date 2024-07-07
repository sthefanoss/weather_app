import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/controllers/weather_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/forecast_list_tile.dart';

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
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Obx(() {
        final state = controller.state.value;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24) + const EdgeInsets.only(top: 24),
                child: Text(
                  controller.location,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (state case ErrorState(:final offline))
              SliverToBoxAdapter(
                child: Column(
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
                      onPressed: controller.getWeatherForecast,
                      child: const Text('Retry'),
                    )
                  ],
                ),
              )
            else if (state case SuccessState(:final data) || CachedState(:final data)) ...[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                      ]),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: data.entries.length,
                  (context, index) => ForecastListTile(forecastEntry: data.entries[index]),
                ),
              ),
            ] else
              const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
          ],
        );
      }),
    );
  }
}
