import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/controllers/current_weather_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/services/responses/current_weather_response.dart';
import 'package:weather_app/services/weather_api_service.dart';

class MockWeatherApiService extends Mock implements WeatherApiService {}

class MockCurrentWeatherResponse extends Mock implements CurrentWeatherResponse {}

String get locationMatcher => any<String>(named: 'location');

void main() {
  const locationTest = 'London, UK';

  setUp(() {
    Get.put<WeatherApiService>(MockWeatherApiService());
  });

  group('CurrentWeatherController', () {
    tearDown(() {
      Get.delete<WeatherApiService>(force: true);
    });

    test('initial state is InitialState', () {
      final controller = CurrentWeatherController(location: locationTest);

      expect(controller.state.value, isA<InitialState>());
    });

    test('state goes to LoadingState after fetchCurrentWeather is called', () async {
      final controller = CurrentWeatherController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      when(() => service.getCurrentWeather(location: locationMatcher)) //
          .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 50), () => MockCurrentWeatherResponse()));

      controller.fetchCurrentWeather();

      expect(controller.state.value, isA<LoadingState>());
    });

    test('state goes to SuccessState after fetchCurrentWeather is complete successfully', () async {
      final controller = CurrentWeatherController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      final response = MockCurrentWeatherResponse();
      when(() => service.getCurrentWeather(location: locationMatcher)) //
          .thenAnswer((_) async => response);
      when(() => response.main)
          .thenReturn(Main(humidity: 80, pressure: 1000, tempMax: 25.0, tempMin: 15.0, temp: 20.0, feelsLike: 22.0));
      when(() => response.wind).thenReturn(Wind(speed: 10, deg: 20));
      when(() => response.weather)
          .thenReturn([Weather(description: 'Clouds', iconUrl: 'iconUrl', id: 1, main: 'main')]);
      when(() => response.rain).thenReturn(Rain(oneHour: 1.0, threeHours: 2.0));
      when(() => response.snow).thenReturn(Snow(oneHour: 3.0, threeHours: 4.0));

      await controller.fetchCurrentWeather();

      expect(controller.state.value, isA<SuccessState>());
      expect(
        (controller.state.value as SuccessState).data,
        const CurrentWeatherModel(
          rain: 1.0,
          snow: 3.0,
          humidity: 80,
          windSpeed: 10,
          temperature: 20.0,
          weather: [WeatherModel(description: 'Clouds', iconUrl: 'iconUrl')],
        ),
      );
    });

    test('state goes to ErrorState after fetchCurrentWeather is complete with error', () async {
      final controller = CurrentWeatherController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      when(() => service.getCurrentWeather(location: locationMatcher)) //
          .thenThrow((_) async => 'Any Error');

      await controller.fetchCurrentWeather();

      expect(controller.state.value, isA<ErrorState>());
    });

    test('WeatherApiService.getCurrentWeather is called with location=$locationTest', () async {
      final controller = CurrentWeatherController(location: locationTest);
      final service = Get.put<WeatherApiService>(MockWeatherApiService());
      when(() => service.getCurrentWeather(location: locationMatcher)) //
          .thenThrow((_) async => 'Any Error');

      controller.fetchCurrentWeather();

      verify(() => service.getCurrentWeather(location: locationTest)).called(1);
    });
  });
}
