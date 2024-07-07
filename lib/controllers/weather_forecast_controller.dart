import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/models/weather_forecast_model.dart';
import 'package:weather_app/services/weather_api_service.dart';

class WeatherForecastController extends GetxController {
  final String location;
  final state = Rx<ControllerState<WeatherForecastModel>>(const InitialState());

  WeatherForecastController({required this.location});

  @override
  void onInit() {
    super.onInit();
    getWeatherForecast();
  }

  Future<void> getWeatherForecast() async {
    if (state.value is LoadingState) return;

    state.value = const LoadingState();

    try {
      final response = await Get.find<WeatherApiService>().getWeatherForecast(location: location);
      final convertedModel = WeatherForecastModel.fromWeatherForecastResponse(response);
      state.value = SuccessState(convertedModel);
    } catch (e) {
      state.value = ErrorState(errorMessage: e.toString());
    }
  }
}
