import 'package:get/get.dart';
import 'package:weather_app/utils/string_utils.dart';

class ConcertListController extends GetxController {
  final _concertPlaces = [
    'Silverstone, UK',
    'São Paulo, Brazil',
    'Melbourne, Australia',
    'Monte Carlo, Monaco',
  ];

  final _filterNormalized = ''.obs;

  void setFilter(String filter) {
    _filterNormalized.value = filter.toLowerCase().withoutDiacriticalMarks;
  }

  List<String> get concertPlaces {
    if (_filterNormalized.isEmpty) {
      return _concertPlaces;
    }

    return _concertPlaces
        .map<({String name, String normalized})>((location) => (
              name: location,
              normalized: location.toLowerCase().withoutDiacriticalMarks,
            ))
        .where((location) => location.normalized.contains(_filterNormalized.value))
        .map((location) => location.name)
        .toList();
  }
}
