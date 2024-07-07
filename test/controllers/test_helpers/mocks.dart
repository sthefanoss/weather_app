import 'package:mocktail/mocktail.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/services/responses/current_weather_response.dart';
import 'package:weather_app/services/responses/weather_forecast_response.dart';
import 'package:weather_app/services/weather_api_service.dart';

class MockWeatherApiService extends Mock implements WeatherApiService {}

class MockWeatherForecastResponse extends Mock implements WeatherForecastResponse {}

class MockCurrentWeatherResponse extends Mock implements CurrentWeatherResponse {}

class MockLocalStorageService extends Mock implements LocalStorageService {}
