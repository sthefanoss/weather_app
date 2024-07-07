import 'package:get/get.dart';
import 'package:weather_app/controllers/cached_controller.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/models/weather_forecast_model.dart';
import 'package:weather_app/services/weather_api_service.dart';

class WeatherForecastController extends GetxController with CachedControllerMixin<WeatherForecastModel> {
  final String location;
  final state = Rx<ControllerState<WeatherForecastModel>>(const InitialState());

  WeatherForecastController({required this.location, this.cacheDuration = const Duration(minutes: 15)});

  @override
  void onInit() {
    super.onInit();
    getWeatherForecast();
  }

  // Make request to get weather forecast. If cache is available, return it.
  // If cache is expired, make request to get weather forecast and update cache.
  Future<void> getWeatherForecast() async {
    if (state.value is LoadingState) return;

    final cachedData = getCachedData();
    if (cachedData != null) {
      state.value = CachedState(
        cachedData.data,
        offline: false,
        lastUpdated: cachedData.timestamp,
      );
      return;
    }

    state.value = const LoadingState();

    try {
      final response = await Get.find<WeatherApiService>().getWeatherForecast(location: location);
      final convertedModel = WeatherForecastModel.fromWeatherForecastResponse(response);
      state.value = SuccessState(convertedModel);

      updateCache(convertedModel);
    } catch (e) {
      state.value = ErrorState(errorMessage: e.toString());
    }
  }

  @override
  final Duration cacheDuration;

  @override
  String get cacheKey => 'weather_forecast_$location';

  @override
  WeatherForecastModel cacheDecode(Map<String, dynamic> value) => //
      WeatherForecastModel.fromJson(value);

  @override
  Map<String, dynamic> cacheEncode(WeatherForecastModel value) => //
      value.toJson();
}
