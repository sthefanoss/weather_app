import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/controllers/current_weather_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/services/weather_api_service.dart';

class MockWeatherApiService extends Mock implements WeatherApiService {}

void main() {
  setUp(() {
    Get.put<WeatherApiService>(MockWeatherApiService());
  });

  group('CurrentWeatherController', () {
    test('initial state is InitialState', () {
      final controller = CurrentWeatherController(location: 'London');

      expect(controller.state.value, isA<InitialState>());
    });
  });
}
