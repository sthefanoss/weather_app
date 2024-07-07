import 'package:weather_app/services/responses/weather_forecast_response.dart';

class WeatherForecastModel {
  /// TUDO use only useful data
  final WeatherForecastResponse data;

  WeatherForecastModel(this.data);

  WeatherForecastModel.fromWeatherForecastResponse(WeatherForecastResponse response) : data = response;
}
