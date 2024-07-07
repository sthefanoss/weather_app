import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/concert_list_page.dart';
import 'package:weather_app/pages/current_weather_page.dart';
import 'package:weather_app/pages/weather_forecast_page.dart';

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
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      getPages: [
        GetPage(
          name: ConcertListPage.pageName,
          page: () => const ConcertListPage(),
          binding: ConcertListBindings(),
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
