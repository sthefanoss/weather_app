import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/models/current_weather_model.dart';

class CurrentWeatherController extends GetxController {
  final String location;
  final state = Rx<ControllerState<CurrentWeatherModel>>(const InitialState());

  CurrentWeatherController({required this.location});
}
