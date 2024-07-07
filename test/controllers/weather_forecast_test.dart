import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/controllers/weather_forecast_controller.dart';
import 'package:weather_app/models/weather_forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/services/responses/shared.dart';
import 'package:weather_app/services/responses/weather_forecast_response.dart';
import 'package:weather_app/services/weather_api_service.dart';

import 'test_helpers/matchers.dart';
import 'test_helpers/mocks.dart';

void main() {
  const locationTest = 'London, UK';

  setUp(() {
    Get.put<LocalStorageService>(MockLocalStorageService());
    Get.put<WeatherApiService>(MockWeatherApiService());
  });

  group('WeatherForecastController', () {
    tearDown(() {
      Get.delete<WeatherApiService>(force: true);
      Get.delete<LocalStorageService>(force: true);
    });

    test('initial state is InitialState', () {
      final controller = WeatherForecastController(location: locationTest);

      expect(controller.state.value, isA<InitialState>());
    });

    test('state goes to LoadingState after getWeatherForecast is called', () async {
      final controller = WeatherForecastController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      when(() => service.getWeatherForecast(location: locationMatcher)) //
          .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 50), () => MockWeatherForecastResponse()));

      controller.getWeatherForecast();

      expect(controller.state.value, isA<LoadingState>());
    });

    test('state goes to SuccessState after getWeatherForecast is complete successfully', () async {
      final controller = WeatherForecastController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      final storge = Get.put<LocalStorageService>(MockLocalStorageService());
      final response = MockWeatherForecastResponse();
      when(() => storge.getString(key: keyMatcher)).thenReturn(null);
      when(() => storge.saveString(key: keyMatcher, value: valueMatcher)).thenAnswer((_) async {});
      when(() => service.getWeatherForecast(location: locationMatcher)) //
          .thenAnswer((_) async => response);
      when(() => response.list).thenReturn([
        WeatherList(
          dt: 1620000000,
          main: const Main(
            temp: 20,
            humidity: 50,
            pressure: 1000,
            tempMin: 15,
            tempMax: 25,
            feelsLike: 20,
            seaLevel: 1000,
            grndLevel: 1000,
            tempKf: 0,
          ),
          rain: Rain(oneHour: 0.25),
          snow: Snow(oneHour: 0.5),
          wind: Wind(speed: 10, deg: 180, gust: 15),
          weather: [
            Weather(
              id: 800,
              main: 'Clear',
              description: 'clear sky',
              iconUrl: 'http://openweathermap.org/img/wn/01d.png',
            )
          ],
          clouds: Clouds(all: 0),
          visibility: 10000,
          pop: 0.5,
          sys: const Sys(pod: 'd'),
          dtTxt: '2021-05-03 12:00:00',
        ),
      ]);

      await controller.getWeatherForecast();

      expect(
        controller.state.value,
        SuccessState(
          WeatherForecastModel(
            entries: [
              WeatherForecasEntry(
                timestamp: DateTime.fromMillisecondsSinceEpoch(1620000000 * 1000),
                temperature: 20,
                rain: 0.25,
                snow: 0.5,
                humidity: 50,
                windSpeed: 10,
                weather: const [
                  WeatherModel(
                    description: 'clear sky',
                    iconUrl: 'http://openweathermap.org/img/wn/01d.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });

    test('state goes to ErrorState after fetchCurrentWeather is complete with error', () async {
      final controller = WeatherForecastController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      when(() => service.getWeatherForecast(location: locationMatcher)) //
          .thenThrow((_) async => 'Any Error');

      await controller.getWeatherForecast();

      expect(controller.state.value, isA<ErrorState>());
    });

    test('WeatherApiService.getWeatherForecast is called with location=$locationTest', () async {
      final controller = WeatherForecastController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      when(() => service.getWeatherForecast(location: locationMatcher)) //
          .thenThrow((_) async => 'Any Error');

      controller.getWeatherForecast();

      verify(() => service.getWeatherForecast(location: locationTest)).called(1);
    });
  });
}
