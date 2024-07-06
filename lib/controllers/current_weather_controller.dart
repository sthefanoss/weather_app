import 'package:get/get.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/services/weather_api_service.dart';

class CurrentWeatherController extends GetxController {
  final String location;
  final state = Rx<ControllerState<CurrentWeatherModel>>(const InitialState());

  CurrentWeatherController({required this.location});

  @override
  void onInit() {
    super.onInit();
    fetchCurrentWeather();
  }

  Future<void> fetchCurrentWeather() async {
    if (state.value is LoadingState) return;
    state.value = const LoadingState();

    try {
      final response = await Get.find<WeatherApiService>().getCurrentWeather(location: location);

      //TODO make DTO
      state.value = SuccessState(CurrentWeatherModel());
    } catch (e) {
      state.value = ErrorState(errorMessage: e.toString());
    }
  }
}
