import 'package:get/get.dart';

class ConcertListController extends GetxController {
  final _concertPlaces = [
    'Silverstone, UK',
    'São Paulo, Brazil',
    'Melbourne, Australia',
    'Monte Carlo, Monaco',
  ];

  final _filter = ''.obs;

  void setFilter(String value) {
    _filter.value = value;
  }

  List<String> get concertPlaces {
    if (_filter.isEmpty) {
      return _concertPlaces;
    }

    return _concertPlaces //
        .where((element) => element.toLowerCase().contains(_filter.value.toLowerCase()))
        .toList();
  }
}
