import 'package:get/get.dart';
import 'package:weather_app/controllers/cached_controller.dart';
import 'package:weather_app/controllers/controller_state.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/services/weather_api_service.dart';

class CurrentWeatherController extends GetxController with CachedControllerMixin<CurrentWeatherModel> {
  final String location;
  final state = Rx<ControllerState<CurrentWeatherModel>>(const InitialState());

  CurrentWeatherController({
    required this.location,
    this.cacheDuration = const Duration(minutes: 15),
  });

  @override
  void onInit() {
    super.onInit();
    getCurrentWeather();
  }

  // Make request to get current weather. If cache is available, return it.
  // If cache is expired, make request to get current weather and update cache.
  Future<void> getCurrentWeather() async {
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
      final response = await Get.find<WeatherApiService>().getCurrentWeather(location: location);
      final convertedModel = CurrentWeatherModel.fromCurrentWeatherResponse(response);
      state.value = SuccessState(convertedModel);

      updateCache(convertedModel);
    } on NoConnectionException catch (error) {
      final cachedData = getCachedData(ignoreExpiryTime: true);
      if (cachedData != null) {
        state.value = CachedState(
          cachedData.data,
          offline: true,
          lastUpdated: cachedData.timestamp,
        );
        return;
      }

      state.value = ErrorState(errorMessage: error, offline: true);
    } catch (e) {
      state.value = ErrorState(errorMessage: e.toString());
    }
  }

  @override
  final Duration cacheDuration;

  @override
  String get cacheKey => 'current_weather_$location';

  @override
  CurrentWeatherModel cacheDecode(Map<String, dynamic> value) => //
      CurrentWeatherModel.fromJson(value);

  @override
  Map<String, dynamic> cacheEncode(CurrentWeatherModel value) => //
      value.toJson();
}
