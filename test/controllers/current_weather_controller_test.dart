import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/controllers/current_weather_controller.dart';
import 'package:mocktail/mocktail.dart';
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
      when(() => service.getCurrentWeather(location: locationMatcher)) //
          .thenAnswer((_) async => MockCurrentWeatherResponse());

      await controller.fetchCurrentWeather();

      expect(controller.state.value, isA<SuccessState>());
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
