import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/controllers/weather_forecast_controller.dart';
import 'package:weather_app/services/local_storage_service.dart';
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

    // TODO
    // test('state goes to SuccessState after getWeatherForecast is complete successfully', () async {
    //   final controller = WeatherForecastController(location: locationTest);
    //   final service = Get.put<WeatherApiService>(MockWeatherApiService());
    //   final storge = Get.put<LocalStorageService>(MockLocalStorageService());
    //   final response = MockWeatherForecastResponse();
    //   when(() => storge.getString(key: keyMatcher)).thenReturn(null);
    //   when(() => storge.saveString(key: keyMatcher, value: valueMatcher)).thenAnswer((_) async {});
    //   when(() => service.getWeatherForecast(location: locationMatcher)) //
    //       .thenAnswer((_) async => response);
    //   when(() => response.main)
    //       .thenReturn(Main(humidity: 80, pressure: 1000, tempMax: 25.0, tempMin: 15.0, temp: 20.0, feelsLike: 22.0));
    //   when(() => response.wind).thenReturn(Wind(speed: 10, deg: 20));
    //   when(() => response.weather)
    //       .thenReturn([Weather(description: 'Clouds', iconUrl: 'iconUrl', id: 1, main: 'main')]);
    //   when(() => response.rain).thenReturn(Rain(oneHour: 1.0, threeHours: 2.0));
    //   when(() => response.snow).thenReturn(Snow(oneHour: 3.0, threeHours: 4.0));

    //   await controller.getWeatherForecast();

    //   expect(
    //     controller.state.value,
    //     const SuccessState(

    //   );
    // });

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
