import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/models/weather_forecast_model.dart';

class WeatherForecastController extends GetxController {
  final String location;
  final state = Rx<ControllerState<WeatherForecastModel>>(const InitialState());

  WeatherForecastController({required this.location});
}
