import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/concert_list_page.dart';
import 'package:weather_app/pages/current_weather_page.dart';
import 'package:weather_app/pages/weather_forecast_page.dart';

import 'pages/splash_page.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      getPages: [
        GetPage(
          name: SplashPage.pageName,
          page: () => const SplashPage(),
          binding: SplashBindings(),
        ),
        GetPage(
          name: ConcertListPage.pageName,
          page: () => const ConcertListPage(),
          binding: CurrentWeatherBindings(),
        ),
        GetPage(
          name: CurrentWeatherPage.pageName,
          page: () => const CurrentWeatherPage(),
          binding: CurrentWeatherBindings(),
        ),
        GetPage(
          name: WeatherForecastPage.pageName,
          page: () => const WeatherForecastPage(),
          binding: WeatherForecastBindings(),
        ),
      ],
    );
  }
}
